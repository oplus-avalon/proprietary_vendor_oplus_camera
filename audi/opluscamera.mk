LOCAL_PATH := vendor/oplus/camera/audi

# Blob dependencies
PRODUCT_PACKAGES += \
    android.hardware.graphics.common-V3-ndk.vendor \
    CameraThemedIcon \
    ColorOSGalleryTarget

# Framework
# PRODUCT_BOOT_JARS += \
#    oplus-framework

# Init
#PRODUCT_PACKAGES += \
#    init.oplus.camera.rc

# Permissions
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/oplus_google_lens_config.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/oplus_google_lens_config.xml \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-oplus.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-oplus.xml \
    $(LOCAL_PATH)/configs/sysconfig/hiddenapi-package-oplus-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/hiddenapi-package-oplus-whitelist.xml

# Properties
PRODUCT_PRODUCT_PROPERTIES += \
    persist.vendor.camera.privapp.list=com.oplus.camera \
    ro.com.google.lens.oem_camera_package=com.oplus.camera \
    ro.oplus.system.camera.name=com.oplus.camera \
    ro.camera.disableHeicUltraHDR=1 \
    oplus.software.camera.10bit=1 \
    vendor.camera.skip_unconfigure.packagelist=com.oplus.camera \
    ro.oplus.camera.facing.front.need.disable.nfc=1 \
    ro.oplus.camera.speechassist=true \
    ro.camera.privileged.3rdpartyApp=com.mediatek.expert.mtkcamhelper;com.aiunit.aon; \
    persist.sys.oplus.anim_level=1 \
    ro.build.version.module.sub_api=2 \
    ro.build.version.oplus.api=38 \
    ro.build.version.oplus.sub_api=48 \
    ro.build.version.oplusrom=V16.1.0 \
    ro.build.version.oplusrom.confidential=V16.1.0 \
    ro.build.version.oplusrom.display=16.1 \
    ro.oplus.theme.version=16000 \
    ro.oplus.camera.defercap.support=1 \
    ro.oplus.camera.defercap.all.quick.visible.support=1 \
    ro.oplus.camera.portrait.center.switch=oplus.switch.portrait.center \
    ro.oplus.camera.portrait_center.prefix=oplus.portrait.center. \
    ro.oplus.camera.video.beauty.switch=oplus.switch.video.beauty \
    ro.oplus.camera.video_beauty.prefix=oplus.video.beauty. \
    ro.oplus.system.camera.flashlight=com.oplus.motor.flashlight \
    persist.logd.log.load.camerahalserver.lower_limit=1000 \
    persist.logd.log.load.camerahalserver.threshold=800000 \
    persist.logd.log.load.camerahalserver.upper_limit=3000 \
    persist.logd.log.load.com.oplus.camera.lower_limit=1000 \
    persist.logd.log.load.com.oplus.camera.threshold=800000 \
    persist.logd.log.load.com.oplus.camera.upper_limit=3000 \
    persist.logd.log.load.vendor.qti.camera.provider-service_64.lower_limit=500 \
    persist.logd.log.load.vendor.qti.camera.provider-service_64.threshold=400000 \
    persist.logd.log.load.vendor.qti.camera.provider-service_64.upper_limit=1500 \

# Camera
$(call soong_config_set,camera,target_ships_oplus_cam,true)
$(call soong_config_set,camera,allow_nonincreasing_timestamps,true)
$(call soong_config_set,libgui,num_buffer_slots,96)

# OPlus FWK
$(call inherit-product, hardware/oplus/oplus-fwk/oplus-fwk.mk)

# Photo
$(call soong_config_set,camera,package_name,com.oplus.packageName)

# Video
$(call soong_config_set_bool,camera,override_format_from_reserved,true)

# Inherit from camera-vendor.mk
$(call inherit-product, vendor/oplus/camera/audi/blobs/blobs-vendor.mk)

# Common SEpolicy
include vendor/oplus/camera/sepolicy/SEPolicy.mk
