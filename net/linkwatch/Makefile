include $(TOPDIR)/rules.mk

PKG_NAME:=linkwatch
PKG_VERSION:=2016-02-17
PKG_RELEASE=1
PKG_LICENSE:=GPL-2.0
PKG_MAINTAINER:=Christian Lamparter <chunkeey@gmail.com>

include $(INCLUDE_DIR)/package.mk

define Package/linkwatch
  SECTION:=net
  CATEGORY:=Network
  TITLE:=link dhcp link updater daemon for bridged wan
endef

define Build/Compile
        true
endef

define Package/linkwatch/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) ./files/linkwatch $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/linkwatch.init $(1)/etc/init.d/linkwatch
endef

$(eval $(call BuildPackage,linkwatch))

