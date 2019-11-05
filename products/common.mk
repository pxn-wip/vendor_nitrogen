 # Generic product
PRODUCT_NAME := nitrogen
PRODUCT_BRAND := nitrogen
PRODUCT_DEVICE := oneplus6

PIXEN_VERSION := PiXeN-OS-10-$(PRODUCT_DEVICE)-$(shell date +"%Y%m%d")-$(shell date -u +%H)$(shell date -u +%M)-OFFICIAL

NITROGEN_BUILD_DATE := $(shell date -u +%Y%m%d-%H%M)

EXCLUDE_SYSTEMUI_TESTS := true

PRODUCT_BUILD_PROP_OVERRIDES := BUILD_DISPLAY_ID=$(TARGET_PRODUCT)-$(PLATFORM_VERSION)-$(BUILD_ID)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.com.android.dataroaming=false \
    drm.service.enabled=true \
    net.tethering.noprovisioning=true \
    persist.sys.dun.override=0 \
    ro.build.selinux=1 \
    ro.adb.secure=0 \
    ro.setupwizard.rotation_locked=true \
    ro.opa.eligible_device=true \
    persist.sys.disable_rescue=true \
    ro.config.calibration_cad=/system/etc/calibration_cad.xml

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    org.nitrogen.fingerprint=$(PLATFORM_VERSION)-$(BUILD_ID)-$(NITROGEN_BUILD_DATE)

PRODUCT_DEFAULT_PROPERTY_OVERRIDES := \
    ro.adb.secure=0 \
    ro.secure=0 \
    persist.service.adb.enable=1

# Common overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/nitrogen/overlay/common
DEVICE_PACKAGE_OVERLAYS += vendor/nitrogen/overlay/common

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/nitrogen/prebuilt/common/etc/sysconfig/dialer_experience.xml:system/etc/sysconfig/dialer_experience.xml

PRODUCT_COPY_FILES +=  \
 vendor/nitrogen/config/permissions/privapp-permissions-custom.xml:system/etc/permissions/privapp-permissions-custom.xml \
 vendor/nitrogen/prebuilt/common/etc/init/custom-livedisplay.rc:system/etc/init/custom-livedisplay.rc
# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib - gesture typing
ifeq ($(TARGET_ARCH), $(filter $(TARGET_ARCH), arm64))
PRODUCT_COPY_FILES += \
    vendor/nitrogen/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so \
    vendor/nitrogen/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
else
PRODUCT_COPY_FILES += \
    vendor/nitrogen/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so
endif

# APN
PRODUCT_COPY_FILES += \
    vendor/nitrogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# AR
PRODUCT_COPY_FILES += \
    vendor/nitrogen/prebuilt/common/etc/calibration_cad.xml:system/etc/calibration_cad.xml

# Extra packages
PRODUCT_PACKAGES += \
    Launcher3 \
    messaging \
    Stk \
    Terminal

# CAF
# Telephony packages
#PRODUCT_PACKAGES += \
#    ims-ext-common \
#    telephony-ext

PRODUCT_PACKAGES += \
     NoCutoutOverlay \
    PixelSetupWizardOverlay \
    PixelSetupWizardAodOverlay

# Themed bootanimation
TARGET_MISC_BLOCK_OFFSET ?= 0
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.misc.block.offset=$(TARGET_MISC_BLOCK_OFFSET)
PRODUCT_PACKAGES += \
    misc_writer_system \
    themed_bootanimation

#PRODUCT_BOOT_JARS += \
#    telephony-ext

# Init.d script support
PRODUCT_COPY_FILES += \
    vendor/nitrogen/prebuilt/common/bin/sysinit:system/bin/sysinit \
    vendor/nitrogen/prebuilt/common/etc/init/nitrogen-system.rc:system/etc/init/nitrogen-system.rc \
    vendor/nitrogen/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/nitrogen/prebuilt/common/addon.d/50-nitrogen.sh:system/addon.d/50-nitrogen.sh \
    vendor/nitrogen/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/nitrogen/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/nitrogen/prebuilt/common/bin/system-mount.sh:install/bin/system-mount.sh

# Priv-app config
PRODUCT_COPY_FILES += \
    vendor/nitrogen/config/permissions/privapp-permissions-nitrogen.xml:system/etc/permissions/privapp-permissions-nitrogen.xml \
    vendor/nitrogen/config/permissions/privapp-permissions-nitrogen.xml:system/product/etc/permissions/privapp-permissions-nitrogen.xml

# Boot animations
$(call inherit-product-if-exists, vendor/nitrogen/products/bootanimation.mk)

# Nitrogen OTA
#$(call inherit-product-if-exists, vendor/nitrogen/products/ota.mk)

#include device/lineage/sepolicy/common/sepolicy.mk
