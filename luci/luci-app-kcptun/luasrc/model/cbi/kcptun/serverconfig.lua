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
}

local encrypt_methods = {
	"aes",
	"tea",
	"xor",
	"none",
}

arg[1] = arg[1] or ""

m = Map(kcptun, translate("Kcptun Server Config"))
m.redirect = ds.build_url("admin", "services", "kcptun")

s = m:section(NamedSection, arg[1], "servers", "")
s.addremove = false
s.dynamic = false

o = s:option(Value, "server", translate("Server Address"))
o.datatype = "host"
o.rmempty = false

o = s:option(Value, "server_port", translate("Server Port"))
o.datatype = "port"
o.rmempty = false

o = s:option(Value, "password", translate("Password"))
o.password = true
o.rmempty = false

o = s:option(Value, "redir_port", translate("Redir Port"))
o.datatype = "port"
o.default = 1080
o.rmempty = false

o = s:option(Value, "socks5_port", translate("Socks5 Port"))
o.datatype = "port"
o.default = 1081
o.rmempty = false

o = s:option(ListValue, "mode", translate("Speed Mode"))
o.rmempty = false
o.default = "fast"
for _, v in ipairs(speed_modes) do o:value(v) end

o = s:option(ListValue, "crypt", translate("Encrypt Method"))
o.rmempty = false
for _, v in ipairs(encrypt_methods) do o:value(v) end

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

o = s:option(ListValue, "nocomp", translate("Data Compression"))
o.default = "false"
o.rmempty = false
o:value("false", translate("Enable"))
o:value("true", translate("Disable"))

return m
