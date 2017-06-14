From 41855aa28abfa5051f07ea4b5efb077af51371e3 Mon Sep 17 00:00:00 2001
From: Hikari-no-Tenshi <kyryljan.serhij@gmail.com>
Date: Sat, 25 Jun 2016 18:19:23 +0300
Subject: [PATCH] Set encoder to OMX.google.h264.encoder

---
 src/org/cyanogenmod/screencast/EncoderDevice.java | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/org/cyanogenmod/screencast/EncoderDevice.java b/src/org/cyanogenmod/screencast/EncoderDevice.java
index 64715c2..9c3748b 100644
--- a/src/org/cyanogenmod/screencast/EncoderDevice.java
+++ b/src/org/cyanogenmod/screencast/EncoderDevice.java
@@ -307,7 +307,7 @@ public void start(Attributes attributes) {
         // create a surface from the encoder
         Log.i(LOGTAG, "Starting encoder at " + width + "x" + height);
         try {
-            venc = MediaCodec.createEncoderByType("video/avc");
+            venc = MediaCodec.createByCodecName("OMX.google.h264.encoder");
         } catch (IOException e) {
             Log.wtf(LOGTAG, "Can't create AVC encoder!", e);
         }

