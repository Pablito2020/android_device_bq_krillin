#!/bin/bash
cd ../../../../..
cd system/core
git apply -v ../../device/bq/krillin/mtk/patches/system_core/surfaceflinger.patch
cd ../..
cd bionic
git apply -v ../device/bq/krillin/mtk/patches/bionic/libc.patch
cd ..
cd frameworks/av
git apply -v ../../device/bq/krillin/mtk/patches/frameworks_av/fix_wvm.patch
git apply -v ../../device/bq/krillin/mtk/patches/frameworks_av/capture.patch
git apply -v ../../device/bq/krillin/mtk/patches/frameworks_av/encoders_n.patch
git apply -v ../../device/bq/krillin/mtk/patches/frameworks_av/mtk_color_support.patch
cd ../..
cd packages/apps/Recorder
git apply -v ../../../device/bq/krillin/mtk/patches/packages_apps_Recorder/screen_recording.patch
cd ../../..

