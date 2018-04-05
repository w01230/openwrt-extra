#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 Chen RuiWei <crwbak@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adbyby
PKG_VERSION:=2.7.0
PKG_RELEASE=0

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=John Wang <4585006@gmail.com>

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
	$(INSTALL_DIR) $(1)/usr/share/adbyby/ $(1)/etc/init.d/ $(1)/etc/uci-defaults/ $(1)/etc/config/ $(1)/etc/
	$(CP) ./files/_common/* $(1)/usr/share/adbyby/

#	$(INSTALL_BIN) ./files/binary/$(ARCH) $(1)/usr/share/adbyby/adbyby
	$(INSTALL_BIN) ./files/adbyby.init $(1)/etc/init.d/adbyby

	$(INSTALL_DATA) ./files/adbyby.defaults $(1)/etc/uci-defaults/95-adbyby
	$(INSTALL_DATA) ./files/adbyby.firewall $(1)/usr/share/adbyby/firewall.include
	$(INSTALL_DATA) ./files/adbyby.config $(1)/etc/config/adbyby
endef

$(eval $(call BuildPackage,adbyby))
