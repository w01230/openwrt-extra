#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 Chen RuiWei <crwbak@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adbyby
PKG_VERSION:=2.6
PKG_RELEASE=20160420

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Chen RuiWei <crwbak@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/adbyby
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=Powerful Advertisement Blocker
	URL:=http://www.adbyby.com
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

define Package/adbyby/conffiles
/etc/config/adbyby
endef

define Package/adbyby/install
	$(INSTALL_DIR) $(1)/usr/share/adbyby $(1)/etc/init.d $(1)/etc/uci-defaults $(1)/etc/config $(1)/etc/
	$(CP) ./files/_common/* $(1)/usr/share/adbyby/

ifneq ("$(wildcard $(1)/etc/dnsmasq.d/adblock.conf)","")
	$(CP) ./files/adblock/* $(1)/etc/
endif

ifeq ($(ARCH),arm)
	$(INSTALL_BIN) ./files/arm/adbyby $(1)/usr/share/adbyby/
endif
ifeq ($(ARCH),aarch64)
	$(INSTALL_BIN) ./files/armv7/adbyby $(1)/usr/share/adbyby/
endif
ifeq ($(ARCH),mips)
	$(INSTALL_BIN) ./files/ar71xx/adbyby $(1)/usr/share/adbyby/
endif
ifeq ($(ARCH),mipsel)
	$(INSTALL_BIN) ./files/7620n/adbyby $(1)/usr/share/adbyby/
endif
ifeq ($(ARCH),i386)
	$(INSTALL_BIN) ./files/x86/adbyby $(1)/usr/share/adbyby/
endif
ifeq ($(ARCH),x86_64)
	$(INSTALL_BIN) ./files/x86_64/adbyby $(1)/usr/share/adbyby/
endif
	$(INSTALL_BIN) ./files/adbyby.init $(1)/etc/init.d/adbyby
	$(INSTALL_DATA) ./files/adbyby.defaults $(1)/etc/uci-defaults/95-adbyby
	$(INSTALL_DATA) ./files/adbyby.firewall $(1)/usr/share/adbyby/firewall.include
	$(INSTALL_DATA) ./files/adbyby.config $(1)/etc/config/adbyby
endef

$(eval $(call BuildPackage,adbyby))
