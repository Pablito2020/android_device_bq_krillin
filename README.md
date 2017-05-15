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

### Warning! --- IMPORTANT:

 * You must take backup of the folder data/nvram before installing any rom.

### Working:

 * Wi-Fi
 * RIL (2g,3g and 2g/3g switch)
 * Bluetooth
 * GPS
 * AGPS
 * Vibration
 * Audio
 * Auto brightness
 * Doze
 * RAM and ROM
 * Rotation
 * Sensors (accelerometer, sound sensor, light sensor, gyroscope, compass)
 * Hardware buttons (HOME, BACK, APP_SWITCH + customization of it)
 * HDR
 * Flashlight (statusbar and camera)
 * Camera rear/front (video and photo)
 * Micro SD support
 * MTP and Mass Storage modes
 * Audio over Bluetooth (music, calls .etc)
 * Wi-Fi tethering
 * Double tap to unlock and doubletap2wake full implementation
 * Notification Led (colours + customization)
 * Screencast (must apply mtk patch, thanks to Hikari No Tenshi)
 * OTA Updates (via API.JSON)

### In progress/bugs:

 * Camera megapixels (It is showing 5mpx instead of 8mpx in frontal camera)


### Thanks to (In alphabetichal order):

 * Assusdan (help with kernel sources builded from scratch)
 * Varun Chitre (RIL + Sprout device tree patches)
 * Vo-1 (Sound Fix in kernel)
 * Zormax (Initial cm12.1/13.0 bringup for mt6582 with kernel sources)
