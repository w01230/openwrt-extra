--[[
openwrt-dist-luci: kcptun
]]--

local ds = require "luci.dispatcher"
local uci = luci.model.uci.cursor()

local kcptun = "kcptun"
local m, s, o

local server_table = {}

m = Map(kcptun, translate("Kcptun"), translate("a fast udp tunnel based on kcp protocol"))
m.template = "kcptun/index"

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

o = s:option(DummyValue, "remoteaddr", translate("Remote Address"))
o.width = "20%"

o = s:option(DummyValue, "remoteport", translate("Remote Port"))
o.width = "10%"

o = s:option(DummyValue, "localaddr", translate("Local Address"))
o.width = "20%"

o = s:option(DummyValue, "localport", translate("Local Port"))
o.width = "10%"

o = s:option(DummyValue, "remoteaddr", translate("Ping Latency"))
o.template = "kcptun/ping"
o.width = "15%"

o = s:option(DummyValue, "enable", translate("Enable State"))
o.template = "kcptun/dvalue"
o.width = "15%"

return m
