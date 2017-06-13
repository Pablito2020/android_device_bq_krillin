From f8b838c7fa1a750fcb1ef92f0f3eb2c64b5f734d Mon Sep 17 00:00:00 2001
From: Pablito2020 <socdelbarca72@gmail.com>
Date: Tue, 13 Jun 2017 20:34:02 +0200
Subject: [PATCH] Updater fixes for unnoficial builds. Thanks to @sultanxda

---
 src/com/cyanogenmod/updater/UpdatesSettings.java                   | 5 +----
 src/com/cyanogenmod/updater/requests/UpdatesJsonObjectRequest.java | 3 ++-
 src/com/cyanogenmod/updater/service/UpdateCheckService.java        | 4 ----
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/com/cyanogenmod/updater/UpdatesSettings.java b/src/com/cyanogenmod/updater/UpdatesSettings.java
index 607db25d..0e343762 100644
--- a/src/com/cyanogenmod/updater/UpdatesSettings.java
+++ b/src/com/cyanogenmod/updater/UpdatesSettings.java
@@ -550,9 +550,6 @@ private void refreshPreferences(LinkedList<UpdateInfo> updates) {
         // Clear the list
         mUpdatesList.removeAll();
 
-        // Convert the installed version name to the associated filename
-        String installedZip = "lineage-" + Utils.getInstalledVersion() + ".zip";
-
         // Add the updates
         for (UpdateInfo ui : updates) {
             // Determine the preference style and create the preference
@@ -568,7 +565,7 @@ private void refreshPreferences(LinkedList<UpdateInfo> updates) {
                 style = UpdatePreference.STYLE_COMPLETING;
                 mDownloading = true;
                 mFileName = ui.getFileName();
-            } else if (ui.getFileName().replace("-signed", "").equals(installedZip)) {
+            } else if (ui.getDate() == Utils.getInstalledBuildDate()) {
                 // This is the currently installed version
                 style = UpdatePreference.STYLE_INSTALLED;
             } else if (ui.getDownloadUrl() != null) {
diff --git a/src/com/cyanogenmod/updater/requests/UpdatesJsonObjectRequest.java b/src/com/cyanogenmod/updater/requests/UpdatesJsonObjectRequest.java
index 13d22b75..10975dfa 100644
--- a/src/com/cyanogenmod/updater/requests/UpdatesJsonObjectRequest.java
+++ b/src/com/cyanogenmod/updater/requests/UpdatesJsonObjectRequest.java
@@ -10,6 +10,7 @@
 package com.cyanogenmod.updater.requests;
 
 import com.android.volley.AuthFailureError;
+import com.android.volley.Request;
 import com.android.volley.Response;
 import com.android.volley.toolbox.JsonObjectRequest;
 import org.json.JSONObject;
@@ -23,7 +24,7 @@
 
     public UpdatesJsonObjectRequest(String url, String userAgent, JSONObject jsonRequest,
             Response.Listener<JSONObject> listener, Response.ErrorListener errorListener) {
-        super(url, jsonRequest, listener, errorListener);
+        super(Request.Method.GET, url, jsonRequest, listener, errorListener);
         mUserAgent = userAgent;
     }
 
diff --git a/src/com/cyanogenmod/updater/service/UpdateCheckService.java b/src/com/cyanogenmod/updater/service/UpdateCheckService.java
index 9fc81d63..7e4b441c 100644
--- a/src/com/cyanogenmod/updater/service/UpdateCheckService.java
+++ b/src/com/cyanogenmod/updater/service/UpdateCheckService.java
@@ -205,10 +205,6 @@ private URI getServerURI() {
             updateUri = getString(R.string.conf_update_server_url_def);
         }
 
-        String incrementalVersion = SystemProperties.get("ro.build.version.incremental");
-        updateUri += "/v1/" + Utils.getDeviceType() + "/" +
-                Utils.getInstalledBuildType() + "/" + incrementalVersion;
-
         return URI.create(updateUri);
     }
 

From 2931c9d5b9bb5c1fe5ff7788dd0d61c0388fa932 Mon Sep 17 00:00:00 2001
From: Sultanxda <sultanxda@gmail.com>
Date: Thu, 13 Apr 2017 15:39:13 -0700
Subject: [PATCH] MD5 Check by sultanxda

---
 src/com/cyanogenmod/updater/UpdatesSettings.java   |  3 +-
 src/com/cyanogenmod/updater/misc/Constants.java    |  1 +
 src/com/cyanogenmod/updater/misc/UpdateInfo.java   | 21 +++++-
 .../updater/receiver/DownloadReceiver.java         |  4 ++
 .../service/DownloadCompleteIntentService.java     | 16 +++--
 .../updater/service/DownloadService.java           |  1 +
 .../updater/service/UpdateCheckService.java        |  1 +
 src/com/cyanogenmod/updater/utils/MD5.java         | 84 ++++++++++++++++++++++
 8 files changed, 122 insertions(+), 9 deletions(-)
 create mode 100644 src/com/cyanogenmod/updater/utils/MD5.java

diff --git a/src/com/cyanogenmod/updater/UpdatesSettings.java b/src/com/cyanogenmod/updater/UpdatesSettings.java
index 0e343762..101d765f 100644
--- a/src/com/cyanogenmod/updater/UpdatesSettings.java
+++ b/src/com/cyanogenmod/updater/UpdatesSettings.java
@@ -265,7 +265,7 @@ public void run() {
 
             if (cursor == null || !cursor.moveToFirst()) {
                 // DownloadReceiver has likely already removed the download
-                // from the DB due to failure or signature mismatch
+                // from the DB due to failure or MD5 mismatch
                 status = DownloadManager.STATUS_FAILED;
             } else {
                 status = cursor.getInt(cursor.getColumnIndex(DownloadManager.COLUMN_STATUS));
@@ -364,6 +364,7 @@ public void onClick(DialogInterface dialog, int which) {
                         // Clear the stored data from shared preferences
                         mPrefs.edit()
                                 .remove(Constants.DOWNLOAD_ID)
+                                .remove(Constants.DOWNLOAD_MD5)
                                 .apply();
 
                         showSnack(mContext.getString(R.string.download_cancelled));
diff --git a/src/com/cyanogenmod/updater/misc/Constants.java b/src/com/cyanogenmod/updater/misc/Constants.java
index ae2e3445..0bc465a8 100644
--- a/src/com/cyanogenmod/updater/misc/Constants.java
+++ b/src/com/cyanogenmod/updater/misc/Constants.java
@@ -14,6 +14,7 @@
     // Download related
     public static final String UPDATES_FOLDER = "updates";
     public static final String DOWNLOAD_ID = "download_id";
+    public static final String DOWNLOAD_MD5 = "download_md5";
     public static final String DOWNLOAD_NAME = "download_name";
     public static final String DOWNLOAD_TMP_EXT = ".tmp";
 
diff --git a/src/com/cyanogenmod/updater/misc/UpdateInfo.java b/src/com/cyanogenmod/updater/misc/UpdateInfo.java
index 5104134b..63f6dd3d 100644
--- a/src/com/cyanogenmod/updater/misc/UpdateInfo.java
+++ b/src/com/cyanogenmod/updater/misc/UpdateInfo.java
@@ -34,6 +34,8 @@
     private String mDownloadUrl;
     private String mChangelogUrl;
     private String mVersion;
+    private String mMd5Sum;
+
 
     private Boolean mIsNewerThanInstalled;
 
@@ -84,6 +86,13 @@ public String getType() {
         return mType;
     }
 
+   /**
+     * Get MD5
+     */
+    public String getMD5Sum() {
+        return mMd5Sum;
+    }
+
     /**
      * Get build date
      */
@@ -177,7 +186,8 @@ public boolean equals(Object o) {
         return TextUtils.equals(mFileName, ui.mFileName)
                 && TextUtils.equals(mType, ui.mType)
                 && mBuildDate == ui.mBuildDate
-                && TextUtils.equals(mDownloadUrl, ui.mDownloadUrl);
+                && TextUtils.equals(mDownloadUrl, ui.mDownloadUrl)
+                && TextUtils.equals(mMd5Sum, ui.mMd5Sum);
     }
 
     public static final Parcelable.Creator<UpdateInfo> CREATOR = new Parcelable.Creator<UpdateInfo>() {
@@ -204,6 +214,7 @@ public void writeToParcel(Parcel out, int flags) {
         out.writeLong(mBuildDate);
         out.writeString(mDownloadUrl);
         out.writeString(mVersion);
+        out.writeString(mMd5Sum);
     }
 
     private void readFromParcel(Parcel in) {
@@ -214,6 +225,7 @@ private void readFromParcel(Parcel in) {
         mBuildDate = in.readLong();
         mDownloadUrl = in.readString();
         mVersion = in.readString();
+        mMd5Sum = in.readString();
     }
 
     public static class Builder {
@@ -225,6 +237,7 @@ private void readFromParcel(Parcel in) {
         private String mDownloadUrl;
         private String mChangelogUrl;
         private String mVersion;
+        private String mMd5Sum;
 
         public Builder setName(String uiName) {
             mUiName = uiName;
@@ -266,6 +279,11 @@ public Builder setVersion(String version) {
             return this;
         }
 
+        public Builder setMD5Sum(String md5Sum) {
+            mMd5Sum = md5Sum;
+            return this;
+        }
+
         public UpdateInfo build() {
             UpdateInfo info = new UpdateInfo();
             info.mUiName = mUiName;
@@ -276,6 +294,7 @@ public UpdateInfo build() {
             info.mDownloadUrl = mDownloadUrl;
             info.mChangelogUrl = mChangelogUrl;
             info.mVersion = mVersion;
+            info.mMd5Sum = mMd5Sum;
             return info;
         }
 
diff --git a/src/com/cyanogenmod/updater/receiver/DownloadReceiver.java b/src/com/cyanogenmod/updater/receiver/DownloadReceiver.java
index c936e361..6ce54da1 100644
--- a/src/com/cyanogenmod/updater/receiver/DownloadReceiver.java
+++ b/src/com/cyanogenmod/updater/receiver/DownloadReceiver.java
@@ -76,16 +76,20 @@ private void handleDownloadComplete(Context context, long id) {
             return;
         }
 
+        String downloadedMD5 = prefs.getString(Constants.DOWNLOAD_MD5, "");
+
         // Send off to DownloadCompleteIntentService
         Intent intent = new Intent(context, DownloadCompleteIntentService.class);
         intent.putExtra(Constants.DOWNLOAD_ID, id);
         intent.putExtra(Constants.DOWNLOAD_NAME, fileName);
+        intent.putExtra(Constants.DOWNLOAD_MD5, downloadedMD5);
         context.startService(intent);
 
         // Clear the shared prefs
         prefs.edit()
                 .remove(Constants.DOWNLOAD_ID)
                 .remove(Constants.DOWNLOAD_NAME)
+                .remove(Constants.DOWNLOAD_MD5)
                 .apply();
     }
 }
diff --git a/src/com/cyanogenmod/updater/service/DownloadCompleteIntentService.java b/src/com/cyanogenmod/updater/service/DownloadCompleteIntentService.java
index 7dacea79..5ba55e45 100644
--- a/src/com/cyanogenmod/updater/service/DownloadCompleteIntentService.java
+++ b/src/com/cyanogenmod/updater/service/DownloadCompleteIntentService.java
@@ -24,6 +24,7 @@
 import com.cyanogenmod.updater.misc.Constants;
 import com.cyanogenmod.updater.receiver.DownloadNotifier;
 import com.cyanogenmod.updater.utils.Utils;
+import com.cyanogenmod.updater.utils.MD5;
 
 import java.io.File;
 import java.io.FileInputStream;
@@ -49,13 +50,16 @@ public DownloadCompleteIntentService() {
 
     @Override
     protected void onHandleIntent(Intent intent) {
-        if (!intent.hasExtra(Constants.DOWNLOAD_ID) || !intent.hasExtra(Constants.DOWNLOAD_NAME)) {
+        if (!intent.hasExtra(Constants.DOWNLOAD_ID) ||
+                !intent.hasExtra(Constants.DOWNLOAD_NAME) ||
+                !intent.hasExtra(Constants.DOWNLOAD_MD5)) {
             Log.e(TAG, "Missing intent extra data");
             return;
         }
 
         long id = intent.getLongExtra(Constants.DOWNLOAD_ID, -1);
         final String destName = intent.getStringExtra(Constants.DOWNLOAD_NAME);
+        String downloadedMD5 = intent.getStringExtra(Constants.DOWNLOAD_MD5);
 
         Intent updateIntent = new Intent(this, UpdatesActivity.class);
         updateIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK |
@@ -94,17 +98,15 @@ protected void onHandleIntent(Intent intent) {
                 return;
             }
 
-            // Check the signature of the downloaded file
-            try {
-                android.os.RecoverySystem.verifyPackage(destFileTmp, null, null);
-            } catch (Exception e) {
-                Log.e(TAG, "Verification failed", e);
+            // Start the MD5 check of the downloaded file
+            if (!MD5.checkMD5(downloadedMD5, destFileTmp)) {
+                Log.e(TAG, "Verification failed");
                 if (destFileTmp.exists()) {
                     destFileTmp.delete();
                     displayErrorResult(updateIntent, R.string.verification_failed);
                 } else {
                     // The download was probably stopped. Exit silently
-                    Log.e(TAG, "Error while verifying the file", e);
+                    Log.e(TAG, "Error while verifying the file");
                 }
                 return;
             }
diff --git a/src/com/cyanogenmod/updater/service/DownloadService.java b/src/com/cyanogenmod/updater/service/DownloadService.java
index 54fb9d3c..0da36292 100644
--- a/src/com/cyanogenmod/updater/service/DownloadService.java
+++ b/src/com/cyanogenmod/updater/service/DownloadService.java
@@ -89,6 +89,7 @@ private void downloadFullZip() {
         mPrefs.edit()
                 .putLong(Constants.DOWNLOAD_ID, downloadId)
                 .putString(Constants.DOWNLOAD_NAME, mInfo.getFileName())
+                .putString(Constants.DOWNLOAD_MD5, mInfo.getMD5Sum())
                 .apply();
 
         Utils.cancelNotification(this);
diff --git a/src/com/cyanogenmod/updater/service/UpdateCheckService.java b/src/com/cyanogenmod/updater/service/UpdateCheckService.java
index 7e4b441c..d9ae4957 100644
--- a/src/com/cyanogenmod/updater/service/UpdateCheckService.java
+++ b/src/com/cyanogenmod/updater/service/UpdateCheckService.java
@@ -252,6 +252,7 @@ private UpdateInfo parseUpdateJSONObject(JSONObject obj) throws JSONException {
         UpdateInfo ui = new UpdateInfo.Builder()
                 .setFileName(obj.getString("filename"))
                 .setDownloadUrl(obj.getString("url"))
+                .setMD5Sum(obj.getString("md5sum"))
                 .setApiLevel(Build.VERSION.SDK_INT) // TODO: remove this entirely
                 .setBuildDate(obj.getLong("datetime"))
                 .setType(obj.getString("romtype"))
diff --git a/src/com/cyanogenmod/updater/utils/MD5.java b/src/com/cyanogenmod/updater/utils/MD5.java
new file mode 100644
index 00000000..cacbd59f
--- /dev/null
+++ b/src/com/cyanogenmod/updater/utils/MD5.java
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2012 The CyanogenMod Project
+ *
+ * * Licensed under the GNU GPLv2 license
+ *
+ * The text of the license can be found in the LICENSE file
+ * or at https://www.gnu.org/licenses/gpl-2.0.txt
+ */
+
+package com.cyanogenmod.updater.utils;
+
+import android.text.TextUtils;
+import android.util.Log;
+
+import java.io.File;
+import java.io.FileInputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.math.BigInteger;
+import java.security.MessageDigest;
+import java.security.NoSuchAlgorithmException;
+
+public class MD5 {
+    private static final String TAG = "MD5";
+
+    public static boolean checkMD5(String md5, File updateFile) {
+        if (TextUtils.isEmpty(md5) || updateFile == null) {
+            Log.e(TAG, "MD5 string empty or updateFile null");
+            return false;
+        }
+
+        String calculatedDigest = calculateMD5(updateFile);
+        if (calculatedDigest == null) {
+            Log.e(TAG, "calculatedDigest null");
+            return false;
+        }
+
+        Log.v(TAG, "Calculated digest: " + calculatedDigest);
+        Log.v(TAG, "Provided digest: " + md5);
+
+        return calculatedDigest.equalsIgnoreCase(md5);
+    }
+
+    public static String calculateMD5(File updateFile) {
+        MessageDigest digest;
+        try {
+            digest = MessageDigest.getInstance("MD5");
+        } catch (NoSuchAlgorithmException e) {
+            Log.e(TAG, "Exception while getting digest", e);
+            return null;
+        }
+
+        InputStream is;
+        try {
+            is = new FileInputStream(updateFile);
+        } catch (FileNotFoundException e) {
+            Log.e(TAG, "Exception while getting FileInputStream", e);
+            return null;
+        }
+
+        byte[] buffer = new byte[8192];
+        int read;
+        try {
+            while ((read = is.read(buffer)) > 0) {
+                digest.update(buffer, 0, read);
+            }
+            byte[] md5sum = digest.digest();
+            BigInteger bigInt = new BigInteger(1, md5sum);
+            String output = bigInt.toString(16);
+            // Fill to 32 chars
+            output = String.format("%32s", output).replace(' ', '0');
+            return output;
+        } catch (IOException e) {
+            throw new RuntimeException("Unable to process file for MD5", e);
+        } finally {
+            try {
+                is.close();
+            } catch (IOException e) {
+                Log.e(TAG, "Exception on closing MD5 input stream", e);
+            }
+        }
+    }
+}


From aac674fd86039092b2bb8c94f8a6d45c7fea21e4 Mon Sep 17 00:00:00 2001
From: Pablito2020 <socdelbarca72@gmail.com>
Date: Tue, 13 Jun 2017 20:44:05 +0200
Subject: [PATCH]  Clear stored download name in order to refresh properly  thx
 sultanxda

---
 src/com/cyanogenmod/updater/UpdatesSettings.java | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/com/cyanogenmod/updater/UpdatesSettings.java b/src/com/cyanogenmod/updater/UpdatesSettings.java
index 101d765f..028040a4 100644
--- a/src/com/cyanogenmod/updater/UpdatesSettings.java
+++ b/src/com/cyanogenmod/updater/UpdatesSettings.java
@@ -364,6 +364,7 @@ public void onClick(DialogInterface dialog, int which) {
                         // Clear the stored data from shared preferences
                         mPrefs.edit()
                                 .remove(Constants.DOWNLOAD_ID)
+                                .remove(Constants.DOWNLOAD_NAME)
                                 .remove(Constants.DOWNLOAD_MD5)
                                 .apply();
 


