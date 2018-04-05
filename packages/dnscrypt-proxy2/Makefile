#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 John Wang <4585006@gmail.com> 
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.0.8
PKG_RELEASE=0

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=John Wang <4585006@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy2
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=New version of dnscrypt_proxy 
	URL:=http://dnscrypt.info
	DEPENDS:=
	VARIANT:=
endef

define Build/Prepare
	$(CP) ./files/Makefile $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/dnscrypt-proxy2/install
	$(INSTALL_DIR) $(1)/usr/bin/ $(1)/etc/init.d/ $(1)/etc/uci-defaults/ $(1)/etc/dnscrypt-proxy2 $(1)/etc/
	$(CP) ./files/_common/* $(1)/etc/dnscrypt-proxy2/

#	$(INSTALL_BIN) ./files/binary/$(ARCH) $(1)/usr/bin/dnscrypt-proxy2
#	$(INSTALL_BIN) ./files/dnscrypt-proxy2.init $(1)/etc/init.d/dnscrypt-proxy2

#	$(INSTALL_DATA) ./files/dnscrypt-proxy2.defaults $(1)/etc/uci-defaults/95-dnscrypt-proxy2
#	$(INSTALL_DATA) ./files/dnscrypt-proxy2.firewall $(1)/usr/share/dnscrypt-proxy2/firewall.include
endef

$(eval $(call BuildPackage,dnscrypt-proxy2))
