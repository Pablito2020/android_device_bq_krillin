#!/bin/bash
cd ../../../..
cd system/core
git apply -v ../../device/bq/krillin/mtk/patches/surfaceflinger.patch
cd ../..
cd bionic
git apply -v ../device/bq/krillin/mtk/patches/libc.patch
cd ..
cd frameworks/av
git checkout -v ../../device/bq/krillin/mtk/patches/fix_wvm.patch
git checkout -v ../../device/bq/krillin/mtk/patches/capture.patch
git checkout -v ../../device/bq/krillin/mtk/patches/encoders_n.patch
git checkout -v ../../device/bq/krillin/mtk/patches/mtk_color_support.patch
cd ../..
