--[[
openwrt-dist-luci: ShadowSocks
]]--

local ds = require "luci.dispatcher"
local ipkg = require "luci.model.ipkg"
local uci = luci.model.uci.cursor()

local shadowsocks = "shadowsocks"
local m, s, o

function is_installed(name)
	return ipkg.installed(name)
end

local server_table = {}

uci:foreach(shadowsocks, "servers", function(s)
	if s.server and s.server_port then
		server_table[s[".name"]] = "%s:%s" %{s.server, s.server_port}
	end
end)

m = Map(shadowsocks, translate("Shadowsocks"), translate("A lightweight secured SOCKS5 proxy"))
m.template = "shadowsocks/index"

-- [[ Running Status ]]--
s = m:section(TypedSection, "global", translate("Running Status"))
s.anonymous = true

o = s:option(DummyValue, "ss_redir_status", translate("Transparent Proxy"))
o.template = "shadowsocks/dvalue"
o.value = translate("Collecting data...")

-- [[ Global Setting ]]--
s = m:section(TypedSection, "global", translate("Global Setting"))
s.anonymous = true

o = s:option(ListValue, "global_server", translate("Current Server"))
o.default = "nil"
o.rmempty = false
o:value("nil", translate("Disable"))
for k, v in pairs(server_table) do o:value(k, v) end

o = s:option(ListValue, "proxy_mode", translate("Default")..translate("Proxy Mode"))
o.default = "gfwlist"
o.rmempty = false
o:value("disable", translate("No Proxy"))
o:value("global", translate("Global Proxy"))
o:value("gfwlist", translate("GFW List"))
o:value("chnroute", translate("China WhiteList"))
o:value("gamemode", translate("Game Mode"))

o = s:option(ListValue, "dns_mode", translate("DNS Forward Mode"))
o.default = "dns2socks"
o.rmempty = false
o:reset_values()
if is_installed("dns2socks") then
	o:value("dns2socks", "dns2socks")
end
o:value("ss-tunnel", "ss-tunnel")
o:value("pdnsd", "pdnsd")
o:value("dnscrypt-proxy2", "dnscrypt-proxy2")

o = s:option(Value, "dns_forward", translate("DNS Forward Address"))
o.default = "8.8.8.8:53"
o.rmempty = false

-- [[ Servers List ]]--
s = m:section(TypedSection, "servers", translate("Servers List"))
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"
s.extedit = ds.build_url("admin", "services", "shadowsocks", "serverconfig", "%s")
function s.create(self, section)
	local new = TypedSection.create(self, section)
	luci.http.redirect(ds.build_url("admin", "services", "shadowsocks", "serverconfig", new))
end
function s.remove(self, section)
	self.map.proceed = true
	self.map:del(section)
	luci.http.redirect(ds.build_url("admin", "services", "shadowsocks"))
end

o = s:option(DummyValue, "server", translate("Server Address"))
o.width = "30%"

o = s:option(DummyValue, "server_port", translate("Server Port"))
o.width = "20%"

o = s:option(DummyValue, "encrypt_method", translate("Encrypt Method"))
o.width = "20%"

o = s:option(DummyValue, "server", translate("Ping Latency"))
o.template = "shadowsocks/ping"
o.width = "20%"

s = m:section(TypedSection, "acl_rule", translate("Shadowsocks ACLs"),
	translate("ACLs is a tools which used to designate specific IP proxy mode"))
s.template  = "cbi/tblsection"
s.sortable  = true
s.anonymous = true
s.addremove = true

o = s:option(Value, "ipaddr", translate("IP Address"))
o.width = "40%"
o.datatype    = "ip4addr"
o.placeholder = "0.0.0.0/0"

o = s:option(ListValue, "proxy_mode", translate("Proxy Mode"))
o.width = "30%"
o.default = "disable"
o.rmempty = false
o:value("disable", translate("No Proxy"))
o:value("global", translate("Global Proxy"))
o:value("gfwlist", translate("GFW List"))
o:value("chnroute", translate("China WhiteList"))
o:value("gamemode", translate("Game Mode"))

o = s:option(Value, "ports", translate("Dest Ports"))
o.width = "30%"
o.placeholder = "80,443"

return m
