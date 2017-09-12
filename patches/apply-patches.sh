#!/bin/bash
cd ../../../..
cd system/core
git apply -v ../../device/bq/krillin/patches/surfaceflinger.patch
cd ../..
cd bionic
git apply -v ../device/bq/krillin/patches/libc.patch
cd ..
cd frameworks/av
git apply -v ../../device/bq/krillin/patches/fix_wvm.patch
git apply -v ../../device/bq/krillin/patches/capture.patch
git apply -v ../../device/bq/krillin/patches/encoders_n.patch
git apply -v ../../device/bq/krillin/patches/mtk_color_support.patch
cd ../..
