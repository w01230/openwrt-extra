#
# Copyright (C) 2015-2017 John Wang <4585006@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.0.16
PKG_RELEASE:=1

PKG_ARCH:=$(subst mipsel,mipsle,$(ARCH))
PKG_ARCH:=$(subst aarch64,arm64,$(ARCH))
PKG_SOURCE:=dnscrypt-proxy-linux_$(PKG_ARCH)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/jedisct1/dnscrypt-proxy/releases/download/$(PKG_VERSION)/
PKG_HASH:=skip
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/dnscrypt-proxy2
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=A Secure DNS resolver
	URL:=https://github.com/jedisct1/dnscrypt-proxy
	DEPENDS:=+ca-bundle
endef

define Package/dnscrypt-proxy2/description
	A flexible DNS proxy, with support for encrypted DNS protocols.
endef

define Build/Compile
	gzip -dc "$(DL_DIR)/$(PKG_SOURCE)" | tar -C $(PKG_BUILD_DIR)/ -xf -
endef

define Package/dnscrypt-proxy2/install
	$(INSTALL_DIR) $(1)/usr/bin/ $(1)/etc/init.d/ i$(1)/etc/uci-defaults/ $(1)/etc/dnsproxy-proxy2 
#	$(INSTALL_BIN) ./files/dnscrypt-proxy2.init $(1)/etc/init.d/dnscrypt-proxy2
#	$(INSTALL_DATA) ./files/dnscrypt-proxy2.defaults $(1)/etc/uci-defaults/95-dnscrypt-proxy2
#	$(INSTALL_DATA) ./files/dnscrypt-proxy2.firewall $(1)/usr/share/dnscrypt-proxy2/firewall.include
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/example-blacklist.txt $(1)/etc/dnscrypt-proxy2/blacklist.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/example-whitelist.txt $(1)/etc/dnscrypt-proxy2/whitelist.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/example-forwarding-rules.txt $(1)/etc/dnscrypt-proxy2/forwarding-rules.txt
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/example-cloaking-rules.txt $(1)/etc/dnscrypt-proxy2/cloaking-rules.txt
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/example-dnscrypt-proxy.toml $(1)/etc/dnscrypt-proxy2/dnscrypt-proxy.toml
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/linux-$(PKG_ARCH)/dnscrypt-proxy $(1)/usr/bin/dnscrypt-proxy2
endef

$(eval $(call BuildPackage,dnscrypt-proxy2))
