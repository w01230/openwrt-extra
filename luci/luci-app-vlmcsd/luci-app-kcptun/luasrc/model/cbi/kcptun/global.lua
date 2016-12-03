--[[
openwrt-dist-luci: kcptun
]]--

local ds = require "luci.dispatcher"
local ipkg = require("luci.model.ipkg")
local uci = luci.model.uci.cursor()

local pkg_name
local min_version = "1.0-20161102"
local kcptun = "kcptun"
local m, s, o

function is_installed(name)
	return ipkg.installed(name)
end

function get_version()
	local version = "1.0-1"
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
