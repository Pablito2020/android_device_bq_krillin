## Aquaris E4.5

The BQ Aquaris E4.5 (codenamed _"krillin"_) is a low-range smartphone from bq.

The BQ Aquaris E4.5 was announced in 2014.

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | 1.3GHz Quad-Core MT6582
GPU     | Mali-400MP
Memory  | 1GB RAM
Shipped Android Version | 4.4.2
Storage | 8GB
Battery | 2100 mAh
Display | 4.5" 960 x 540 px
Camera  | 8MPx, LED Flash

![Krillin](https://faqsandroid.com/wp-content/uploads/2014/05/3-BQ-Aquaris-E.jpg "All three krillin")

This branch is for building Nougat ROMS and TWRP recovery

### Full Compilation guide:

     * repo init -u git://github.com/LineageOS/android.git -b cm-14.1

     * repo sync --force-sync 

     * . build/envsetup.sh

     * lunch lineage_krillin-userdebug

### Recovery Compilation (TWRP Variant):

  Enter to the "scripts" directory (device/bq/krillin/scripts):

     * . twrp.sh

     * lineage_krillin-userdebug

     * mka recoveryimage

### If you have a compilation error with jack server do:

  Enter to the "scripts" directory (device/bq/krillin/scripts):

     * . jack.sh

### Contributors (In alphabetichal order):

 * Assusdan
 * Chymardos
 * DanielHK
 * Deckersu
 * Kra1o5
 * MAD team (Fire855, DragonPT and Derteufel)
 * Samar Vispute
 * Varun Chitre
 * Vo-1
 * Xcore
 * Zormax
