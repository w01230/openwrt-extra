--[[
openwrt-dist-luci: kcptun
]]--

module("luci.controller.kcptun", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/kcptun") then
		return
	end

	entry({"admin", "services", "kcptun"}, cbi("kcptun/global"), _("Kcptun"), 2).dependent = true
	entry({"admin", "services", "kcptun", "serverconfig"}, cbi("kcptun/serverconfig")).leaf = true
	entry({"admin", "services", "kcptun", "ping"}, call("act_ping")).leaf = true
end

function act_ping()
	local result = { }
	result.index = luci.http.formvalue("index")
	result.ping = luci.sys.exec("ping -c 1 -W 1 %q 2>&1|grep -o 'time=[0-9]*.[0-9]'|awk -F '=' '{print$2}'" % luci.http.formvalue("domain"))
	luci.http.prepare_content("application/json")
	luci.http.write_json(result)
end
