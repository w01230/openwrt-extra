include $(TOPDIR)/rules.mk

PKG_NAME:=vlmcsd
PKG_VERSION=2018-10-20_svn1112
PKG_RELEASE:=1

PKG_MAINTAINER:=panda-mute <wxuzju@gmail.com>
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Wind4/vlmcsd.git
PKG_SOURCE_VERSION:=cd488aeb85aedefe1cb4db02c632397d78a9de88

PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR)-$(PKG_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_SOURCE_SUBDIR)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vlmcsd
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=vlmcsd for OpenWRT
	URL:=https://github.com/Wind4/vlmcsd
	DEPENDS:=+libpthread
endef

define Package/vlmcsd/description
	vlmcsd is a KMS Emulator in C.
endef

define Package/vlmcsd/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/etc/vlmcsd.ini $(1)/etc/vlmcsd.ini
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/bin/vlmcsd
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcs $(1)/usr/bin/vlmcs
endef

$(eval $(call BuildPackage,vlmcsd))
