#!/bin/bash
rm -rf prebuilts/clang/host/linux-x86
rm -rf device/xiaomi/sky device/xiaomi/sky-kernel vendor/xiaomi/sky
rm -rf hardware/xiaomi hardware/xiaomi

repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh || repo sync

git clone https://github.com/xiaomi-sm4450-sky/android_device_xiaomi_sky.git -b 16.2 device/xiaomi/sky
git clone https://github.com/xiaomi-sm4450-sky/android_vendor_xiaomi_sky.git -b 16.2 vendor/xiaomi/sky
git clone https://github.com/xiaomi-sm4450-sky/android_xiaomi_sky-kernel.git -b 16.2 device/xiaomi/sky-kernel

export BUILD_USERNAME=XETRA
export BUILD_HOSTNAME=darthvader
export TARGET_DISABLE_MATLOG=true
export TARGET_SUPPORTS_BLUR=false
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

export INFINITY_MAINTAINER="XETRA"

. build/envsetup.sh
lunch infinity_sky-user
m bacon -j$(nproc --all)
