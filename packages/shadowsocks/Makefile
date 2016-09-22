#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 Chen RuiWei <crwbak@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shadowsocks
PKG_VERSION:=2.4.8
PKG_RELEASE=1

PKG_SOURCE_URL:=https://github.com/shadowsocks/shadowsocks-libev/archive/
PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_MD5SUM:=8b300e5732a594245fa9c08fd7fbf738

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Chen RuiWei <crwbak@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/shadowsocks-libev-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

PKG_USE_MIPS16:=0
PKG_FIXUP:=autoreconf

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/shadowsocks/Default
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=Lightweight Secured Socks5 Proxy $(2)
	URL:=https://github.com/shadowsocks/shadowsocks-libev
	VARIANT:=$(1)
	DEPENDS:=$(3)
endef

Package/shadowsocks = $(call Package/shadowsocks/Default,openssl,(OpenSSL),+libopenssl +libpthread +ipset +ip +iptables-mod-tproxy)
Package/shadowsocks-polarssl = $(call Package/shadowsocks/Default,polarssl,(PolarSSL),+libpolarssl +libpthread +ipset +ip +iptables-mod-tproxy)
Package/shadowsocks-mbedtls = $(call Package/shadowsocks/Default,mbedtls,(mbedTLS),+libmbedtls +libpthread +ipset +ip +iptables-mod-tproxy)

define Package/shadowsocks/description
shadowsocks is a lightweight secured socks5 proxy for embedded devices and low end boxes.
endef

Package/shadowsocks-polarssl/description = $(Package/shadowsocks/description)
Package/shadowsocks-mbedtls/description = $(Package/shadowsocks/description)

define Package/shadowsocks/conffiles
/etc/config/shadowsocks
endef

Package/shadowsocks-polarssl/conffiles = $(Package/shadowsocks/conffiles)

CONFIGURE_ARGS += --disable-documentation --disable-ssp

ifeq ($(BUILD_VARIANT),polarssl)
	CONFIGURE_ARGS += --with-crypto-library=polarssl
endif

ifeq ($(BUILD_VARIANT),mbedtls)
	CONFIGURE_ARGS += --with-crypto-library=mbedtls
endif

define Package/shadowsocks/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d $(1)/etc/uci-defaults $(1)/usr/share/shadowsocks $(1)/etc/config
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/ss-{redir,tunnel,local} $(1)/usr/bin/
	$(INSTALL_BIN) ./files/shadowsocks.init $(1)/etc/init.d/shadowsocks
	$(INSTALL_DATA) ./files/shadowsocks.defaults $(1)/etc/uci-defaults/96-shadowsocks
	$(INSTALL_DATA) ./files/shadowsocks.firewall $(1)/usr/share/shadowsocks/firewall.include
	$(INSTALL_DATA) ./files/chnroute.txt $(1)/usr/share/shadowsocks/
	$(INSTALL_DATA) ./files/shadowsocks.config $(1)/etc/config/shadowsocks
endef

Package/shadowsocks-polarssl/install = $(Package/shadowsocks/install)
Package/shadowsocks-mbedtls/install = $(Package/shadowsocks/install)

$(eval $(call BuildPackage,shadowsocks))
$(eval $(call BuildPackage,shadowsocks-polarssl))
$(eval $(call BuildPackage,shadowsocks-mbedtls))
