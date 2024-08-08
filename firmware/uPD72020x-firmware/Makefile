include $(TOPDIR)/rules.mk

PKG_NAME:=uPD72020x-firmware
PKG_RELEASE:=3

PKG_FLAGS:=nonshared

include $(INCLUDE_DIR)/package.mk

define Package/uPD72020x-firmware
  SECTION:=firmware
  CATEGORY:=Firmware
  TITLE:=Renesas uPD720201 and uPD720202 firmware
endef

define Package/uPD72020x-firmware/description
  Firmware for the Renesas USB3.0 Host Controllers uPD720201 and uPD720202.
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/uPD72020x-firmware/install
	$(INSTALL_DIR) $(1)/lib/firmware/
	$(INSTALL_DATA) ./files/K2026090.mem $(1)/lib/firmware/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/sysloadfw.init $(1)/etc/init.d/sysloadfw
endef

$(eval $(call BuildPackage,uPD72020x-firmware))
