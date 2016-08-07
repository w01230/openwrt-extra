--[[
LuCI - Lua Configuration Interface - adbyby support

Script by oldoldstone@gmail.com 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id$
]]--

module("luci.controller.adbyby", package.seeall)

function index()	
	if not nixio.fs.access("/etc/config/adbyby") then
		return
	end
	local page 
	page = entry({"admin", "services", "adbyby"}, cbi("adbyby"), _("adbyby"), 50)
	page.i18n = "adbyby"
	page.dependent = true
end
