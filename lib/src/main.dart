import 'dart:io';

import 'package:flutter/services.dart';

import 'exceptions/os_not_support.dart';
import 'settings/android_download_setting.dart';

class FlutterDownloadFile {
  late AndroidDownloadSetting _androidSettings;

  FlutterDownloadFile({AndroidDownloadSetting? androidSettings}) {
    _androidSettings = androidSettings ?? AndroidDownloadSetting();
  }

  final MethodChannel _channel = const MethodChannel('flutter_download_file');

  Future<void> startDownload(String url) async {
    if (Platform.isAndroid) {
      await _channel.invokeMethod('downloadFile', {"url": url, "isShowNotification": _androidSettings.isShowNotification});
    } else if (Platform.isIOS) {
      await _channel.invokeMethod('downloadFile', {"url": url});
    } else {
      throw OSNotSupportException(Platform.operatingSystem);
    }
  }
}