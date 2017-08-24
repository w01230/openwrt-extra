# Some extra packages for OpenWrt/LEDE

## usage:

	0) move extra to openwrt(or LEDE)/packages
	
	1) select luci app and make

## bug:
	do not start koolproxy
	1) need remove koolproxy in /usr/share/koolproxy
	2）download koolproxy form https://koolproxy.com/downloads/$(ARCH) ($(ARCH) = mips mipsel arm or x86_64)
	
## Thanks:
     Thanks for releated githuber. @crwnet @shadowsocks etc.
