#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/oneplus/hotdogb device/oneplus/sm8150-common kernel/oneplus/sm8150 vendor/oneplus/hotdogb vendor/oneplus/sm8150-common hardware/oplus

repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

git clone https://github.com/jhaidh277/A16-qp2 --depth 1 -b og-7t .repo/local_manifests

/opt/crave/resync.sh

sudo apt update
sudo apt install ccache -y

sed -i '/Calendar/d' build/make/target/product/gsi/Android.bp

export INFINITY_OFFICIAL=false
export Infinity_Official=false

source build/envsetup.sh
lunch infinity_hotdogb-userdebug

mka bacon -j$(nproc)
