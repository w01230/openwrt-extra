--[[
openwrt-dist-luci: koolproxy
]]--

local ds = require "luci.dispatcher"
local uci = luci.model.uci.cursor()

local koolproxy = "koolproxy"
local m, s, o

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
o:value("global", translate("Global Filter"))
o:value("adblocks", translate("AdBlock Filter(HTTPS)"))
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
o:value("global", translate("Global Filter"))
o:value("adblocks", translate("AdBlock Filter(HTTPS)"))
o:value("globals", translate("Global Filter(HTTPS)"))

return m
