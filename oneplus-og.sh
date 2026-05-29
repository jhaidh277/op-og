#!/bin/bash

# 1. Clean up existing manifests and conflicting directories
rm -rf .repo/local_manifests
rm -rf device/oneplus/hotdogb device/oneplus/sm8150-common kernel/oneplus/sm8150 vendor/oneplus/hotdogb vendor/oneplus/sm8150-common hardware/oplus

# 2. Initialize remote repository
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

# 3. Clone local manifests
git clone https://github.com/jhaidh277/A16-qp2 --depth 1 -b og-7t .repo/local_manifests

# 4. Sync source code using Crave script
/opt/crave/resync.sh

# 5. Install ccache if not present
sudo apt update && sudo apt install ccache -y

# 6. Fix Calendar build BP error
sed -i '"/Calendar",/d' build/make/target/product/gsi/Android.bp

# 7. Bypass official signing key requirements to prevent build failure
export INFINITY_OFFICIAL=false
export Infinity_Official=false

# 8. Setup environment and lunch target device
source build/envsetup.sh
lunch infinity_hotdogb-userdebug

# 9. Start the build process utilizing maximum CPU cores
mka bacon -j$(nproc)
