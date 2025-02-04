# config.mk
#
# Product-specific compile-time definitions.
#

DEVICE_PATH := device/xiaomi/topaz
KERNEL_PATH := kernel/msm-5.15

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    init_boot \
    odm \
    product \
    recovery \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot \
    vendor_dlkm

# Board Info
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := bengal
TARGET_NO_BOOTLOADER := true

# Build
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES  := true
BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE := true

# DTB/DTBO
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_USES_DT := true
BOARD_PREBUILT_DTBIMAGE_DIR := $(KERNEL_PATH)/dtbs
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbo.img

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/configs/vintf/xiaomi_framework_compatibility_matrix.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/manifest.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/xiaomi_manifest.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/configs/vintf/xiaomi_odm_manifest.xml

# Init
TARGET_INIT_VENDOR_LIB := //$(DEVICE_PATH):libinit_topaz
TARGET_RECOVERY_DEVICE_MODULES := libinit_topaz

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)

BOARD_KERNEL_CMDLINE := \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    disable_dma32=on \
    mtdoops.fingerprint=$(AOSPA_VERSION) \
    swinfo.fingerprint=$(AOSPA_VERSION)

BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=4e00000.dwc3

# Kernel prebuilt
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := $(KERNEL_PATH)/kernel-headers
TARGET_KERNEL_VERSION := 5.15

TARGET_NO_KERNEL_OVERRIDE := true

TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel

PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL):kernel

# Kernel modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/vendor/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE :=  $(KERNEL_PATH)/modules/vendor/modules.blocklist
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat  $(KERNEL_PATH)/modules/ramdisk/modules.load))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/modules/ramdisk/modules.blocklist
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_PATH)/modules/ramdisk/modules.load.recovery))

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/modules/ramdisk/,$(TARGET_COPY_OUT_VENDOR_RAMDISK)/lib/modules) \
    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/modules/system/,$(TARGET_COPY_OUT_SYSTEM_DLKM)/lib/modules/5.15.78) \
    $(call find-copy-subdir-files,*,$(KERNEL_PATH)/modules/vendor/,$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules)

# OTA assert
TARGET_OTA_ASSERT_DEVICE := topaz,tapas

# Partitions
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_SUPER_PARTITION_SIZE := 6442450944
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext system_dlkm odm product vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 6438256640

BOARD_BOOTIMAGE_PARTITION_SIZE := 0x8000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x1800000
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 0x800000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x6400000
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x6000000
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_USES_METADATA_PARTITION := true
BOARD_METADATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_METADATAIMAGE_PARTITION_SIZE := 67108864

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_USERDATAIMAGE_PARTITION_SIZE := 17179869184

TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_PRODUCT := product
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_SYSTEM_EXT := system_ext
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_USES_SYSTEM_DLKMIMAGE := true
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Power
TARGET_POWER_FEATURE_EXT_LIB := //$(DEVICE_PATH):libpowerfeature_ext_topaz
TARGET_TAP_TO_WAKE_NODE ?= "/proc/tp_gesture"

# Recovery
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_F2FS := true

SOONG_CONFIG_NAMESPACES += ufsbsg
SOONG_CONFIG_ufsbsg += ufsframework
SOONG_CONFIG_ufsbsg_ufsframework := bsg

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(DEVICE_PATH)

# Screen density
TARGET_SCREEN_DENSITY := 420

# Security patch level
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Sepolicy
include device/xiaomi/topaz/sepolicy/topaz-sepolicy.mk

# Treble flag
BOARD_VNDK_VERSION := current

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 4

BOARD_AVB_DTBO_ALGORITHM := SHA256_RSA4096
BOARD_AVB_DTBO_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_DTBO_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_DTBO_ROLLBACK_INDEX_LOCATION := 3

BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

BOARD_AVB_VBMETA_SYSTEM := system system_dlkm system_ext product
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2

BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 5

BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

# Inherit from the proprietary version
include vendor/xiaomi/topaz/BoardConfigVendor.mk
