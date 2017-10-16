#!/bin/bash
#
# TWRP Script for lineage os
#
# Copyright (C) 2017 Pablo Fraile Alonso (Github aka: Pablito2020)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>

# Go to the lineage os directory
cd ../../../..

# Clone the recovery and the busybox tools
git clone https://github.com/LineageOS/android_external_busybox external/busybox
git clone https://github.com/OmniROM/android_bootable_recovery bootable/recovery-twrp

# Build Script...
. build/envsetup.sh

# Say that you're building twrp
export WITH_TWRP=true

# Lunch
lunch
