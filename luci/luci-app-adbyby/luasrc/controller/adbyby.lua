--[[
openwrt-dist-luci: ShadowSocks
]]--

module("luci.controller.adbyby", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/adbyby") then
		return
	end

	entry({"admin", "services", "adbyby"}, cbi("adbyby/global"), _("Adbyby"), 1).dependent = true
	entry({"admin", "services", "adbyby", "status"}, call("act_status")).leaf = true
end

function act_status()
	local result = { }
	result.adbyby = luci.sys.call("pidof %s >/dev/null" % "adbyby") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(result)
end
