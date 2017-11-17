#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 Chen RuiWei <crwbak@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=koolproxy
PKG_VERSION:=3.6.0
PKG_RELEASE=0

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Chen RuiWei <crwbak@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/koolproxy
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=Powerful Advertisement Blocker
	URL:=http://www.koolproxy.com
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

define Package/koolproxy/conffiles
/etc/config/koolproxy
endef

define Package/koolproxy/install
	$(INSTALL_DIR) $(1)/usr/share/koolproxy $(1)/etc/init.d $(1)/etc/uci-defaults $(1)/etc/config $(1)/etc/
	$(CP) ./files/_common/* $(1)/usr/share/koolproxy/

	$(INSTALL_BIN) ./files/binary/$(ARCH) $(1)/usr/share/koolproxy/
	$(INSTALL_BIN) ./files/koolproxy.init $(1)/etc/init.d/koolproxy

	$(INSTALL_DATA) ./files/koolproxy.defaults $(1)/etc/uci-defaults/95-koolproxy
	$(INSTALL_DATA) ./files/koolproxy.firewall $(1)/usr/share/koolproxy/firewall.include
	$(INSTALL_DATA) ./files/koolproxy.config $(1)/etc/config/koolproxy

endef

$(eval $(call BuildPackage,koolproxy))
