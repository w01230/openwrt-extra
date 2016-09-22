--[[
openwrt-dist-luci: kcptun
]]--

local ds = require "luci.dispatcher"
local ipkg = require("luci.model.ipkg")
local uci = luci.model.uci.cursor()

local pkg_name
local min_version = "1.0-20160716"
local kcptun = "kcptun"
local m, s, o

function is_installed(name)
	return ipkg.installed(name)
end

function get_version()
	local version = "1.0.0-1"
	ipkg.list_installed("kcptun*", function(n, v, d)
		pkg_name = n
		version = v
	end)
	return version
end

function compare_versions(ver1, comp, ver2)
	if not ver1 or not (#ver1 > 0)
	or not comp or not (#comp > 0)
	or not ver2 or not (#ver2 > 0) then
		return nil
	end
	return luci.sys.call("opkg compare-versions '%s' '%s' '%s'" %{ver1, comp, ver2}) == 1
end

if compare_versions(min_version, ">>", get_version()) then
	local tip = 'kcptun not found'
	if pkg_name then
		tip = 'Please update the packages: %s' %{pkg_name}
	end
	return Map(kcptun, translate("Kcptun"), '<b style="color:red">%s</b>' %{tip})
end

local server_table = {}

uci:foreach(kcptun, "servers", function(s)
	if s.server and s.server_port then
		server_table[s[".name"]] = "%s:%s" %{s.server, s.server_port}
	end
end)

m = Map(kcptun, translate("Kcptun"), translate("a fast udp tunnel based on kcp protocol"))
m.template = "kcptun/index"

-- [[ Running Status ]]--
s = m:section(TypedSection, "global", translate("Running Status"))
s.anonymous = true

o = s:option(DummyValue, "kcptun_status", translate("Transparent Proxy"))
o.template = "kcptun/dvalue"
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

o = s:option(ListValue, "dns_mode", translate("DNS Forward Mode"))
o.default = "dns2socks"
o.rmempty = false
o:reset_values()
if is_installed("dns2socks") then
	o:value("dns2socks", "dns2socks")
end

o = s:option(Value, "dns_forward", translate("DNS Forward Address"))
o.default = "8.8.8.8:53"
o.rmempty = false

-- [[ Servers List ]]--
s = m:section(TypedSection, "servers", translate("Servers List"))
s.anonymous = true
s.addremove = true
s.template = "cbi/tblsection"
s.extedit = ds.build_url("admin", "services", "kcptun", "serverconfig", "%s")
function s.create(self, section)
	local new = TypedSection.create(self, section)
	luci.http.redirect(ds.build_url("admin", "services", "kcptun", "serverconfig", new))
end
function s.remove(self, section)
	self.map.proceed = true
	self.map:del(section)
	luci.http.redirect(ds.build_url("admin", "services", "kcptun"))
end

o = s:option(DummyValue, "server", translate("Server Address"))
o.width = "30%"

o = s:option(DummyValue, "server_port", translate("Server Port"))
o.width = "20%"

o = s:option(DummyValue, "mode", translate("Speed Mode"))
o.width = "20%"

o = s:option(DummyValue, "server", translate("Ping Latency"))
o.template = "kcptun/ping"
o.width = "20%"

s = m:section(TypedSection, "acl_rule", translate("Kcptun ACLs"),
	translate("ACLs is a tools which used to designate specific IP proxy mode"))
s.template  = "cbi/tblsection"
s.sortable  = true
s.anonymous = true
s.addremove = true

o = s:option(Value, "ipaddr", translate("IP Address"))
o.width = "40%"
o.datatype    = "ip4addr"
o.placeholder = "0.0.0.0/0"
o.rmempty = false

o = s:option(ListValue, "proxy_mode", translate("Proxy Mode"))
o.width = "40%"
o.default = "disable"
o.rmempty = false
o:value("disable", translate("No Proxy"))
o:value("global", translate("Global Proxy"))
o:value("gfwlist", translate("GFW List"))
o:value("chnroute", translate("China WhiteList"))

return m
