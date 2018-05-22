# Some extra packages for OpenWrt/LEDE

## usage:

	0) add src-git extra https://github.com/w01230/openwrt-extra.git to feeds.conf.default 	
	1) run ./script/feeds update -a then ./script/feeds install -a
	2) select app and make

## bug:
	upx compressed binary file(koolproxy) is not put into firmware, if do this
	the binary file will be broken. It needs to copy into openwrt manually via ssh or samba. 	
## Thanks:
     Thanks for [crwnet](httttps://github.com/crwnet), [shadowsocks](https://github.com/shadowsocks) etc.
