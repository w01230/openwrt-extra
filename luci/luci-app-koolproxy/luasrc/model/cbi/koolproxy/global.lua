--[[
openwrt-dist-luci: koolproxy
]]--

local ds = require "luci.dispatcher"
local ipkg = require("luci.model.ipkg")
local uci = luci.model.uci.cursor()

local pkg_name
local min_version = "3.0.0"
local koolproxy = "koolproxy"
local m, s, o

function is_installed(name)
	return ipkg.installed(name)
end

function get_version()
	local version = "1.0.0-1"
	ipkg.list_installed("koolproxy*", function(n, v, d)
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
	local tip = 'koolproxy not found'
	if pkg_name then
		tip = 'Please update the packages: %s' %{pkg_name}
	end
	return Map(koolproxy, translate("koolproxy"), '<b style="color:red">%s</b>' %{tip})
end

m = Map(koolproxy, translate("koolproxy"), translate("A powerful advertisement blocker"))
m.template = "koolproxy/index"

-- [[ Running Status ]]--
s = m:section(TypedSection, "global", translate("Running Status"))
s.anonymous = true

o = s:option(DummyValue, "_status", translate("Transparent Proxy"))
o.template = "koolproxy/dvalue"
o.value = translate("Collecting data...")

-- [[ Global Setting ]]--
s = m:section(TypedSection, "global", translate("Global Setting"))
s.anonymous = true

o = s:option(Flag, "enabled", translate("Enable"))
o.default = 0
o.rmempty = false

o = s:option(ListValue, "filter_mode", translate('Default')..translate("Filter Mode"))
o.default = "adblock"
o.rmempty = false
o:value("disable", translate("No Filter"))
o:value("adblock", translate("AdBlock Filter"))
o:value("global", translate("Global Filter(HTTP)"))
o:value("globals", translate("Global Filter(HTTPS)"))

s = m:section(TypedSection, "acl_rule", translate("ACLs"),
	translate("ACLs is a tools which used to designate specific IP filter mode"))
s.template  = "cbi/tblsection"
s.sortable  = true
s.anonymous = true
s.addremove = true

o = s:option(Value, "ipaddr", translate("IP Address"))
o.width = "40%"
o.datatype    = "ip4addr"
o.placeholder = "0.0.0.0/0"
o.rmempty = false

o = s:option(ListValue, "filter_mode", translate("Filter Mode"))
o.width = "40%"
o.default = "disable"
o.rmempty = false
o:value("disable", translate("No Filter"))
o:value("adblock", translate("AdBlock Filter"))
o:value("global", translate("Global Filter(HTTP)"))
o:value("globals", translate("Global Filter(HTTPS)"))

return m
