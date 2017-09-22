# Inherit needed stuff
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, device/bq/krillin/device.mk)
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Set LOCAL_PATH 
LOCAL_PATH := device/bq/krillin

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_FINGERPRINT=7.1.2/MRA58M/2419427:user/release-keys PRIVATE_BUILD_DESC="krillin-user 7.1.2 MRA58M 2419427 release-keys"

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_DEVICE="krillin"  
       
PRODUCT_NAME := lineage_krillin
PRODUCT_DEVICE :=krillin
PRODUCT_BRAND := bq
PRODUCT_MANUFACTURER := bq
PRODUCT_MODEL := Aquaris E4.5

# set locales & aapt config.
PRODUCT_AAPT_CONFIG := normal mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Inherit some common CM/Lineage OS stuff.
CM_BUILD := krillin
CM_BUILDTYPE := EXPERIMENTAL

# Krillin specific propierties
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp
	
PRODUCT_PROPERTY_OVERRIDES += \
  persist.service.adb.enable=1 \
  persist.service.debuggable=1 \
  persist.sys.usb.config=mtp,adb
