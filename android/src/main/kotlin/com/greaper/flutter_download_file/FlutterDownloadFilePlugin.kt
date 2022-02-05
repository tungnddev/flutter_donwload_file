package com.greaper.flutter_download_file

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterDownloadFilePlugin */
class FlutterDownloadFilePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var downloadManager: DownloadManager


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    downloadManager = DownloadManager(flutterPluginBinding.applicationContext)
    downloadManager.registerBroadcast()
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_download_file")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "downloadFile") {
      val url = call.argument<String>("url")
      val isShowNotification = call.argument<Boolean>("isShowNotification") ?: true
      url ?. let {
        downloadManager.resultMethodChannel = result
        downloadManager.downloadFile(it, isShowNotification)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    downloadManager.unregisterBroadcast()
  }


}
