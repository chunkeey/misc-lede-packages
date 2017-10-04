#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=cryptsetup-beta
PKG_VERSION:=2.0.3
PKG_RELEASE:=1
PKG_LICENSE:=GPL-2.0+ LGPL-2.1+
PKG_LICENSE_FILES:=COPYING COPYING.LGPL

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.com/cryptsetup/cryptsetup.git
PKG_SOURCE_DATE:=2018-05-03
PKG_SOURCE_VERSION:=1763260578600fcf1a2129fe44d9e7b69814a0c8
PKG_MIRROR_HASH:=82e280d63f09952b8663cfeb7625f7961e8329ee878e8ebfa8ffc05696886a22

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

TARGET_LDFLAGS+=-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Package/cryptsetup-beta/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Encryption
  TITLE:=Cryptsetup
  DEPENDS:=+libblkid +libuuid +libpopt +lvm2 +libdevmapper +libjson-c
  URL:=https://gitlab.com/cryptsetup/cryptsetup
endef

define Package/cryptsetup-beta
$(call Package/cryptsetup-beta/Default)
  DEPENDS+=+libgcrypt
  VARIANT:=gcrypt
endef

define Package/cryptsetup-beta-openssl
$(call Package/cryptsetup-beta/Default)
  TITLE+= (with openssl support)
  DEPENDS+=+libopenssl
  VARIANT:=openssl
endef

define Package/cryptsetup-beta/Default/description
  Cryptsetup-luks
endef

define Package/cryptsetup-beta/description
$(call Package/cryptsetup-beta/Default/description)
linked against libgcrypt
endef


define Package/cryptsetup-beta-openssl/description
$(call Package/cryptsetup-beta/Default/description)
linked against openssl
endef

define Build/Configure
	(cd $(PKG_BUILD_DIR); NOCONFIGURE=y ./autogen.sh );
	$(call Build/Configure/Default)
endef

ifeq ($(BUILD_VARIANT),openssl)
CONFIGURE_ARGS+= \
        --with-crypto_backend=openssl
endif

define Package/cryptsetup-beta/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_BUILD_DIR)/.libs/cryptsetup $(1)/usr/sbin
	$(CP) $(PKG_BUILD_DIR)/.libs/integritysetup $(1)/usr/sbin
	$(CP) $(PKG_BUILD_DIR)/.libs/veritysetup $(1)/usr/sbin
	$(CP) $(PKG_BUILD_DIR)/.libs/cryptsetup-reencrypt $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/lib
	$(CP) $(PKG_BUILD_DIR)/.libs/libcryptsetup.so* $(1)/usr/lib
endef

Package/cryptsetup-beta-openssl/install = $(Package/cryptsetup-beta/install)

$(eval $(call BuildPackage,cryptsetup-beta))
$(eval $(call BuildPackage,cryptsetup-beta-openssl))
