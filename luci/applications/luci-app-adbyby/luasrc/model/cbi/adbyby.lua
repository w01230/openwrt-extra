--[[
LuCI - Lua Configuration Interface - mjpg-streamer support

Script by oldoldstone@gmail.com 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

local fs = require "nixio.fs"

local running=(luci.sys.call("pidof adbyby > /dev/null") == 0)
if running then	
	m = Map("adbyby", translate("adbyby"), translate("adbyby is running"))
else
	m = Map("adbyby", translate("adbyby"), translate("adbyby is not running"))
end

s = m:section(TypedSection, "adbyby", "")
s.anonymous = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

forward=s:option(Flag, "forward", translate("Enable autoforward"))
forward.rmempty = false

listen_address = s:option(Value, "listen_address", translate("Listening Address"))
listen_address.datatype = ipaddr
listen_address.optional = false

listen_port = s:option(Value, "listen_port", translate("Listening Port"))
listen_port.datatype = "range(0,65535)"
listen_port.optional = false

buffer_limit= s:option(Value, "buffer_limit", translate("Buffer Limit"))
buffer_limit.optional = false

max_client_connections= s:option(Value, "max_client_connections", translate("Max Client Connections"))
max_client_connections.optional = false

keep_alive_timeout= s:option(Value, "keep_alive_timeout", translate("Keep Alive Timeout"))
keep_alive_timeout.optional = false

socket_timeout= s:option(Value, "socket_timeout", translate("Socket Timeout"))
socket_timeout.optional = false

rule= s:option(Value, "rule", translate("Update Rules"))
rule.optional = false

return m

