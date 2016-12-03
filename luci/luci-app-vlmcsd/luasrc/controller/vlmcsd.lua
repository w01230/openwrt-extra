--[[
openwrt-dist-luci: ShadowSocks
]]--

module("luci.controller.vlmcsd", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/vlmcsd") then
		return
	end
	
	entry({"admin", "services", "vlmcsd"}, cbi("vlmcsd"), _("KMS服务器")).dependent = true
end
