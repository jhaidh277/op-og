#!/bin/bash

rm -rf .repo/local_manifests

repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault

git clone https://github.com/jhaidh277/A16-qp2 --depth 1 -b og-7t .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh
lunch infinity_hotdogb-userdebug

m bacon
