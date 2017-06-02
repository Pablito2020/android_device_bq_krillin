Aquaris E4.5 - LineageOS 13.0
==============

This branch is device for building of the LineageOS 13.0 and other MM ROMS.

---
# About Device

![Aquaris E4.5](https://img.pccomponentes.com/articles/6/67915/bq-aquaris-e4-5-16gb-blanco-libre-4.jpg "Aquaris E4.5")

Announced on 2014, the bq Aquaris E4.5 (codenamed _"krillin"_) is a smartphone from bq. Krillin now supports LineageOS 13.0!

### Specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | 1.3GHz Quad-Core MT6582
GPU     | Mali-400MP
Memory  | 1GB RAM
Shiped Android Version | 6.0.x
Storage | 8GB
Battery | 2150 mAh
Display | 4.5" 540 x 960 px
Camera  | 8MPx, LED Flash

---

# Build Information

### Working:

 * WIFI
 * Bluetooth
 * RIL (calls + 2g + 3g + switch)
 * Camera ( Front + Rare )
 * Video Recording ( Front + rare )
 * Filesystems:

     - F2FS (MUST CHANGE IT IN RECOVERY)
     
     - NTFS (MUST CHANGE IT IN RECOVERY)
 
     - EXT4 (AS DEFAULT IN SYSTEM, DATA AND CACHÉ PARTITION)

     - EXT3 (MUST CHANGE IT IN RECOVERY)

     - EXT2 (MUST CHANGE IT IN RECOVERY)

 * DoubleTap2wake + customization of it
 * Sweep2wake
 * Encoder + Decoders
 * Audio ( speakers + earphones )
 * Screencast app
 * Sensors:

     - Accelerometer
 
     - Compass

     - Gyroscope

     - Sound

     - Rotation

     - Proximity
 

### In progress/bugs:

 * 

### Full Compilation guide:

   repo init -u git://github.com/LineageOS/android.git -b cm-13.0

   repo sync

   add device tree, vendor blobs, kernel source and stlport in his respective paths

   . build/envsetup.sh

   lunch lineage_krillin-userdebug

### Recovery Compilation (TWRP Variant):

  cd booteable

  git clone https://github.com/omnirom/android_bootable_recovery.git recovery-twrp

  cd ..

  . build/envsetup.sh

  lunch

  lineage_krillin-eng
 
  mka -jx recoveryimage   (in x, specify number of cores that your computer have)

### Developer:

 * Pablito2020 ---- HTCMANIA, XDA , 4PDA , GITHUB

### Thanks to (In alphabetichal order):

 * Assusdan (help with kernel sources builded from scratch) ---- GITHUB, 4PDA
 * Hikari No Tenshi ( Screencast App patch ) ---- XDA, GITHUB
 * Varun Chitre (RIL + Sprout device tree patches) ---- XDA, GITHUB
 * Vo-1 (Sound Fix in kernel) ---- XDA, 4PDA , GITHUB
 * Zormax (Initial cm12.1/13.0 bringup for mt6582 with kernel sources) ---- 4PDA
