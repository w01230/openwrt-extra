#
# Copyright (C) 2015-2017 John Wang <4585006@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks
PKG_VERSION:=3.2.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev.git
PKG_SOURCE_VERSION:=8c98bdecac22b5de7637f82c5db458fd57798a68
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.xz

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=John Wang <4585006@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION)

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks/Default
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=Lightweight Secured Socks5 Proxy
	URL:=https://github.com/shadowsocks/shadowsocks-libev
	DEPENDS:=+zlib +libev +libcares +libpcre +libsodium +libmbedtls +ipset +iptables +iptables-mod-tproxy +iptables-mod-extra

endef

Package/shadowsocks = $(Package/shadowsocks/Default)

define Package/shadowsocks/description
Shadowsocks-libev is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

CONFIGURE_ARGS += --disable-ssp --disable-documentation --disable-assert

define Package/shadowsocks/install
	$(shell./files/gfwlist2dnsmasq.sh -s gfwlist -o ./files/common/dnsmasq.d/gfwlist.conf)
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d $(1)/etc/uci-defaults $(1)/etc/shadowsocks $(1)/etc/config $(1)/etc
	$(CP) ./files/common/* $(1)/etc/
	$(CP) ./files/dnsmasq.conf $(TOPDIR)/package/network/services/dnsmasq/files/dnsmasq.conf
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{redir,tunnel,local} $(1)/usr/bin/
	$(INSTALL_BIN) ./files/ss-rules $(1)/usr/bin/
	$(INSTALL_BIN) ./files/shadowsocks.init $(1)/etc/init.d/shadowsocks
	$(INSTALL_DATA) ./files/shadowsocks.defaults $(1)/etc/uci-defaults/96-shadowsocks
	$(INSTALL_DATA) ./files/shadowsocks.firewall $(1)/etc/shadowsocks/firewall.include
	$(INSTALL_DATA) ./files/chnroute.* $(1)/etc/shadowsocks/
	$(INSTALL_DATA) ./files/shadowsocks.config $(1)/etc/config/shadowsocks
	$(INSTALL_DATA) ./files/unbound $(1)/etc/config/unbound
endef

$(eval $(call BuildPackage,shadowsocks))
