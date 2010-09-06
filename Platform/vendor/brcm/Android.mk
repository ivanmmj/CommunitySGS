LOCAL_PATH := $(call my-dir)

#
# copy brcm binaries into android
#
ifeq ($(TARGET_MODEL), Apollo)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bin/Apollo/btld:system/bin/btld \
	$(LOCAL_PATH)/bin/Apollo/BCM4329B1_002.002.023.0417.0420.hcd:system/bin/BCM4329B1_002.002.023.0417.0420.hcd
endif
ifeq ($(TARGET_MODEL), Aries)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bin/Aries/btld:system/bin/btld \
	$(LOCAL_PATH)/bin/Aries/BCM4329B1_002.002.023.0417.0430.hcd:system/bin/BCM4329B1_002.002.023.0417.0430.hcd
endif
ifeq ($(TARGET_MODEL), AriesQ)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bin/AriesQ/btld:system/bin/btld \
	$(LOCAL_PATH)/bin/AriesQ/BCM4329B1_002.002.023.0237.0270_26M.hcd:system/bin/BCM4329B1_002.002.023.0237.0270_26M.hcd
endif
ifeq ($(TARGET_MODEL), Vibrant)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/bin/Vibrant/btld:system/bin/btld \
	$(LOCAL_PATH)/bin/Aries/BCM4329B1_002.002.023.0417.0430.hcd:system/bin/BCM4329B1_002.002.023.0417.0430.hcd
endif
ifeq ($(BOARD_HAVE_BLUETOOTH),true)
    include $(all-subdir-makefiles)
endif