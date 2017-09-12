Aquaris E4.5 - LineageOS 14.1
==============

### Full Compilation guide:

     * repo init -u git://github.com/LineageOS/android.git -b cm-14.1

     * repo sync --force-sync 

     * . build/envsetup.sh

     * lunch lineage_krillin-userdebug

### Recovery Compilation (TWRP Variant):

  LineageOS root / source directory:

     * git clone https://github.com/LineageOS/android_external_busybox external/busybox
     * git clone https://github.com/OmniROM/android_bootable_recovery bootable/recovery-twrp
     * source build/envsetup.sh
     * lunch
     * lineage_krillin-eng
     * export WITH_TWRP=true
     * mka recoveryimage

### Currently broken freatures:

 * Mobile data

### Thanks to (In alphabetichal order):

 * Assusdan
 * Chymardos
 * Deckersu
 * DeVvil
 * kra1o5
 * sultanxda
 * Varun Chitre
 * Vo-1
 * Xcore
 * Zormax
