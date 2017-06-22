include $(TOPDIR)/rules.mk

PKG_NAME:=rtl-433
PKG_RELEASE:=1
CMAKE_INSTALL:=1

PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/merbanan/rtl_433.git
PKG_SOURCE_DATE:=2018-01-30
PKG_SOURCE_VERSION:=fa79cf5e3e7702d8bb51fa6a31cf6173306a7078
PKG_MIRROR_HASH:=e923480842adb5c33800a8f9ba521ebcacaeb0af274027836fa959ddd1f5e91e

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=COPYING

PKG_MAINTAINER:=Christian Lamparter <chunkeey@googlemail.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/rtl-433
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=rtl-sdr based 433 MHz generic data receiver
  DEPENDS:=+libpthread +librtlsdr
  URL:=https://github.com/merbanan/rtl_433
endef

define Package/rtl-433/description
  rtl_433 turns your Realtek RTL2832 based DVB dongle into a 433.92MHz generic data receiver
endef

define Package/rtl-433/conffiles
/etc/config/rtl_433
endef

define Package/rtl-433/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/rtl_433 $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/rtl_433.init $(1)/etc/init.d/rtl_433
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/uci_rtl_433 $(1)/etc/config/rtl_433
endef

$(eval $(call BuildPackage,rtl-433))
