# Some extra packages for OpenWrt/LEDE

## usage:

	0) add src-git extra https://github.com/w01230/openwrt-extra.git to feeds.conf.default 	
	1) run ./script/feeds update -a then ./script/feeds install -a
	2) select app and make

## bug:
	do not start koolproxy
	1) need remove koolproxy in /usr/share/koolproxy
	2）download koolproxy form https://koolproxy.com/downloads/$(ARCH) ($(ARCH) = mips mipsel arm or x86_64)
	
## Thanks:
     Thanks for [crwnet](https://github.com/crwnet), [shadowsocks](https://github.com/shadowsocks) etc.
