Aquaris E4.5 - LineageOS 13.0
==============

### Full Compilation guide:

   repo init -u git://github.com/LineageOS/android.git -b cm-13.0

   repo sync

   add device tree, vendor blobs, kernel source and stlport in his respective paths

   . build/envsetup.sh

   lunch lineage_krillin-userdebug

### Recovery Compilation (TWRP Variant):

  LineageOS root / source directory:

     * git clone https://github.com/LineageOS/android_external_busybox external/busybox
     * git clone https://github.com/OmniROM/android_bootable_recovery bootable/recovery-twrp
     * source build/envsetup.sh
     * lunch
     * lineage_krillin-eng
     * export WITH_TWRP=true
     * mka recoveryimage


### Developer:

 * Pablito2020 ---- HTCMANIA, XDA , 4PDA , GITHUB

### Thanks to (In alphabetichal order):

 * Assusdan (help with kernel sources builded from scratch) ---- GITHUB, 4PDA
 * Hikari No Tenshi ( Screencast App patch ) ---- XDA, GITHUB
 * Varun Chitre (RIL + Sprout device tree patches) ---- XDA, GITHUB
 * Vo-1 (Sound Fix in kernel) ---- XDA, 4PDA , GITHUB
 * Zormax (Initial cm12.1/13.0 bringup for mt6582 with kernel sources) ---- 4PDA
