#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 Chen RuiWei <crwbak@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dns2socks
PKG_VERSION:=1.8
PKG_RELEASE=1

PKG_SOURCE_URL:=https://github.com/crwnet/dns2socks/archive/
PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_MD5SUM:=e3a3f28bb09e23fe3474209d4ca4a287

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Chen RuiWei <crwbak@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/dns2socks-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/dns2socks
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=DNS requests via a SOCKS5 tunnel
	URL:=https://github.com/crwnet/dns2socks
	DEPENDS:=+libpthread
endef

define Package/dns2socks/description
This is a utility to resolve DNS requests via a SOCKS5 tunnel and caches the answers.
endef

define Build/Compile
	$(TARGET_CC) \
	$(TARGET_CFLAGS) \
	$(TARGET_CPPFLAGS) \
	-o $(PKG_BUILD_DIR)/dns2socks \
	$(PKG_BUILD_DIR)/DNS2SOCKS.c \
	$(TARGET_LDFLAGS) -pthread
endef

define Package/dns2socks/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dns2socks $(1)/usr/bin/
endef

$(eval $(call BuildPackage,dns2socks))
