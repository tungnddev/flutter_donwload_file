package com.greaper.flutter_download_file

import android.app.DownloadManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.DOWNLOAD_SERVICE
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import android.os.Environment
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class DownloadManager(var context: Context) {

    private var lastDownloadId = 0L
    var resultMethodChannel: MethodChannel.Result? = null

    fun registerBroadcast() {
        context.registerReceiver(onDownloadComplete, IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE))
    }

    fun unregisterBroadcast() {
        context. unregisterReceiver(onDownloadComplete)
    }

    private val onDownloadComplete: BroadcastReceiver = object : BroadcastReceiver() {

        override fun onReceive(context: Context?, intent: Intent?) {
            val id = intent?.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1)
            if (id == lastDownloadId) {
                resultMethodChannel?.success(true)
            }
        }
    }

    fun downloadFile(url: String, isShowNotification: Boolean) {
        try {
            val fileName= url.getFileName()
            val request = DownloadManager.Request(Uri.parse(url))
                .setNotificationVisibility(if (isShowNotification) DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED else DownloadManager.Request.VISIBILITY_HIDDEN)
                .setDestinationInExternalPublicDir(Environment.DIRECTORY_DOWNLOADS, fileName)
            val downloadManager = context.getSystemService(DOWNLOAD_SERVICE) as DownloadManager
            lastDownloadId = downloadManager.enqueue(request)
        } catch (e: Exception) {
            resultMethodChannel?.success(false)
        }
    }

    private fun String.getFileName() : String {
        if (this.isEmpty()) return ""
        val strArray: Array<String> = this.split("/".toRegex()).toTypedArray()
        return strArray[strArray.size - 1]
    }
}