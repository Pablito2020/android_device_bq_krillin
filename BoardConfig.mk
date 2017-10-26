LOCAL_PATH := device/bq/krillin

# bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := Aquaris_E45

# platform
TARGET_BOARD_PLATFORM := mt6582
MTK_BOARD_PLATFORMS := mt6582

# arch
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
ARCH_ARM_HAVE_VFP := true
TARGET_CPU_SMP := true
TARGET_ARCH := arm
ARCH_ARM_HAVE_NEON := true
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a7
TARGET_CPU_VARIANT:= cortex-a7
TARGET_CPU_MEMCPY_OPT_DISABLE := true

# partitions (via cat /proc/partitions)
BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 10485760
BOARD_SYSTEMIMAGE_PARTITION_SIZE:=1073741824
BOARD_USERDATAIMAGE_PARTITION_SIZE:=5886705664
BOARD_CACHEIMAGE_PARTITION_SIZE:=743003200
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

# filesystems (ext4, f2fs and exfat)
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_KERNEL_HAVE_EXFAT := true
BOARD_HAS_LARGE_FILESYSTEM := true

# USB [vold]
BOARD_VOLD_MAX_PARTITIONS := 25
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"

# boot
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/tools/bootimg.mk
MTK_PLATFORM := mt6582
MTK_PROJECT := krillin
TARGET_KERNEL_SOURCE := kernel/bq/krillin
TARGET_KERNEL_CONFIG := lineage_krillin_defconfig
BOARD_KERNEL_CMDLINE := console=tty0 console=ttyMT3,921600n1 root=/dev/ram vmalloc=496M slub_max_order=0 slub_debug=0 androidboot.hardware=sprout androidboot.selinux=permissive
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

# Don't build with ninja
USE_NINJA=false

# Cyanogenmod Hardware Hooks
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := device/bq/krillin/cmhw/

# Dexpreopt
WITH_DEXPREOPT := false
DISABLE_DEXPREOPT := true

# LightHAL
TARGET_PROVIDES_LIBLIGHT := true

# light path
BACKLIGHT_PATH := /sys/class/leds/lcd-backlight/brightness

# sensors
TARGET_NO_SENSOR_PERMISSION_CHECK := true

# zip package
BLOCK_BASED_OTA := false
TARGET_OTA_ASSERT_DEVICE := krillin,Aquaris_E45,alps,giraffe

# twrp recovery
ifeq ($(WITH_TWRP),true)
RECOVERY_VARIANT := twrp
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/etc/recovery.fstab
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_THEME := portrait_hdpi
TW_EXCLUDE_SUPERSU := true
TW_NO_REBOOT_BOOTLOADER := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone1/temp
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0/gadget/lun0/file
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 150
TW_NO_EXFAT_FUSE := true
TW_EXCLUDE_MTP := true
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_NTFS_3G := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
else
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/recovery.fstab
endif

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth

# Mediatek Wlan
BOARD_WLAN_DEVICE	         := MediaTek
BOARD_CONNECTIVITY_VENDOR        := MediaTek
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P
WIFI_DRIVER_STATE_CTRL_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_STATE_ON:=1
WIFI_DRIVER_STATE_OFF:=0

# Minkin and Malloc
USE_MINIKIN := true
MALLOC_SVELTE := true

# fonts
EXTENDED_FONT_FOOTPRINT := true

# prop file
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop

# Mediatek needed flags
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true 
MTK_HARDWARE := true

# Display
USE_OPENGL_RENDERER := true
DEVICE_RESOLUTION := 540x960
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 540
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true

# RIL
SIM_COUNT := 2
TARGET_GLOBAL_CFLAGS += -DANDROID_MULTI_SIM
TARGET_GLOBAL_CPPFLAGS += -DANDROID_MULTI_SIM
BOARD_RIL_CLASS := ../../../$(LOCAL_PATH)/ril/

# Neon Flags
TARGET_GLOBAL_CFLAGS   += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp

# Camera
USE_CAMERA_STUB := true

# selinux policy
BOARD_SEPOLICY_DIRS += \
    device/bq/krillin/sepolicy
