--[[
openwrt-dist-luci: kcptun
]]--

local kcptun = "kcptun"
local ds = require "luci.dispatcher"
local ipkg = require("luci.model.ipkg")
local m, s, o

local speed_modes = {
	"normal",
	"fast",
	"fast2",
	"fast3",
	"manual"
}

local encrypt_methods = {
	"aes",
	"aes-128",
	"aes-192",
	"salsa20",
	"blowfish",
	"twofish",
	"cast5",
	"3des",
	"tea",
	"xtea",
	"xor",
	"none"
}

arg[1] = arg[1] or ""

m = Map(kcptun, translate("Kcptun Server Config"))
m.redirect = ds.build_url("admin", "services", "kcptun")

s = m:section(NamedSection, arg[1], "servers", "")
s.addremove = false
s.dynamic = false

o = s:option(ListValue, "enable", translate("Enable State"))
o.default = "1"
o.rmempty = false
o:value("1", translate("Enable"))
o:value("0", translate("Disable"))

o = s:option(Value, "localaddr", translate("Local Address"))
o.datatype = "host"
o.default = "0.0.0.0"
o.rmempty = false

o = s:option(Value, "localport", translate("Local Port"))
o.datatype = "port"
o.rmempty = false

o = s:option(Value, "remoteaddr", translate("Remote Address"))
o.datatype = "host"
o.rmempty = false

o = s:option(Value, "remoteport", translate("Remote Port"))
o.datatype = "port"
o.rmempty = false

o = s:option(Value, "key", translate("Password"))
o.rmempty = true

o = s:option(ListValue, "crypt", translate("Encrypt Method"))
o.rmempty = false
for _, v in ipairs(encrypt_methods) do o:value(v) end

o = s:option(ListValue, "mode", translate("Speed Mode"))
o.rmempty = false
o.default = "fast"
for _, v in ipairs(speed_modes) do o:value(v) end

o = s:option(Value, "conn", translate("Connections"))
o.datatype = "uinteger"
o.default = 1
o.rmempty = false

o = s:option(Value, "autoexpire", translate("Auto Expire"))
o.datatype = "uinteger"
o.default = 0
o.rmempty = false

o = s:option(Value, "mtu", translate("MTU"))
o.datatype = "uinteger"
o.default = 1350
o.rmempty = false

o = s:option(Value, "sndwnd", translate("Send Window"))
o.datatype = "uinteger"
o.default = 128
o.rmempty = false

o = s:option(Value, "rcvwnd", translate("Recv Window"))
o.datatype = "uinteger"
o.default = 1024
o.rmempty = false

o = s:option(Value, "datashard", translate("Datashard"))
o.datatype = "uinteger"
o.default = 10
o.rmempty = false

o = s:option(Value, "parityshard", translate("Parityshard"))
o.datatype = "uinteger"
o.default = 3
o.rmempty = false

o = s:option(Value, "dscp", translate("DSCP"))
o.datatype = "uinteger"
o.default = 0
o.rmempty = false

o = s:option(ListValue, "nocomp", translate("Data Compression"))
o.default = "false"
o.rmempty = false
o:value("false", translate("Enable"))
o:value("true", translate("Disable"))

o = s:option(ListValue, "acknodelay", translate("Hidden:ACK NoDelay"))
o.default = "true"
o.rmempty = false
o:value("true", translate("Enable"))
o:value("false", translate("Disable"))

o = s:option(ListValue, "nodelay", translate("Hidden:NoDelay"))
o.default = "1"
o.rmempty = false
o:value("1", translate("Enable"))
o:value("0", translate("Disable"))

o = s:option(Value, "interval", translate("Hidden:Interval"))
o.datatype = "uinteger"
o.default = 40
o.rmempty = false

o = s:option(Value, "resend", translate("Hidden:Resend"))
o.datatype = "uinteger"
o.default = 0
o.rmempty = false

o = s:option(Value, "nc", translate("Hidden:NC"))
o.datatype = "uinteger"
o.default = 0
o.rmempty = false

o = s:option(Value, "sockbuf", translate("Socket Buffer"))
o.datatype = "uinteger"
o.default = 4194304
o.rmempty = false

o = s:option(Value, "keepalive", translate("Keep Alive"))
o.datatype = "uinteger"
o.default = 10
o.rmempty = false

return m
