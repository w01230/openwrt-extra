--[[
openwrt-dist-luci: ShadowSocks
]]--

module("luci.controller.shadowsocks", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/shadowsocks") then
		return
	end

	entry({"admin", "services", "shadowsocks"}, cbi("shadowsocks/global"), _("ShadowSocks"), 2).dependent = true
	entry({"admin", "services", "shadowsocks", "serverconfig"}, cbi("shadowsocks/serverconfig")).leaf = true
	entry({"admin", "services", "shadowsocks", "status"}, call("act_status")).leaf = true
	entry({"admin", "services", "shadowsocks", "ping"}, call("act_ping")).leaf = true
end

function act_status()
	local result = { }
	result.ss_redir = luci.sys.call("pidof %s >/dev/null" % "ss-redir") == 0
	luci.http.prepare_content("application/json")
	luci.http.write_json(result)
end

function act_ping()
	local result = { }
	result.index = luci.http.formvalue("index")
	result.ping = luci.sys.exec("ping -c 1 -W 1 %q 2>&1|grep -o 'time=[0-9]*.[0-9]'|awk -F '=' '{print$2}'" % luci.http.formvalue("domain"))
	luci.http.prepare_content("application/json")
	luci.http.write_json(result)
end
