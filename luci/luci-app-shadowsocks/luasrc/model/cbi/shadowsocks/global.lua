--[[
openwrt-dist-luci: ShadowSocks
]]--

local ds = require "luci.dispatcher"
local ipkg = require "luci.model.ipkg"
local uci = luci.model.uci.cursor()

local shadowsocks = "shadowsocks"
local m, s, o

local m, s, o
local shadowsocks = "shadowsocks"
local uci = luci.model.uci.cursor()
local nwm = require("luci.model.network").init()
local lan_ifaces = {}
local io = require "io"

local function ipv4_hints(callback)
	local hosts = {}
	uci:foreach("dhcp", "dnsmasq", function(s)
		if s.leasefile and nixio.fs.access(s.leasefile) then
			for e in io.lines(s.leasefile) do
				mac, ip, name = e:match("^%d+ (%S+) (%S+) (%S+)")
				if mac and ip then
					hosts[ip] = name ~= "*" and name or mac:upper()
				end
			end
		end
	end)
	uci:foreach("dhcp", "host", function(s)
		for mac in luci.util.imatch(s.mac) do
			hosts[s.ip] = s.name or mac:upper()
		end
	end)
	for ip, name in pairs(hosts) do
		callback(ip, name)
	end
end

for _, net in ipairs(nwm:get_networks()) do
	if net:name() ~= "loopback" and string.find(net:name(), "wan") ~= 1 then
		net = nwm:get_network(net:name())
		local device = net and net:get_interface()
		if device then
			lan_ifaces[device:name()] = device:get_i18n()
		end
	end
end

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

-- [[ LAN Hosts ]]--
s = m:section(TypedSection, "lan_hosts", translate("LAN Hosts"))
s.template = "cbi/tblsection"
s.addremove = true
s.anonymous = true

o = s:option(Value, "host", translate("Host"))
ipv4_hints(function(ip, name)
	o:value(ip, "%s (%s)" %{ip, name})
end)
o.datatype = "ip4addr"
o.rmempty = false

o = s:option(ListValue, "type", translate("Proxy Type"))
o:value("b", translate("No Proxy"))
o:value("g", translate("Global Proxy"))
o:value("n", translate("GFW List"))
o:value("n", translate("China WhiteList"))
o.rmempty = false

o = s:option(Flag, "enable", translate("Enable"))
o.default = "1"
o.rmempty = false

return m
