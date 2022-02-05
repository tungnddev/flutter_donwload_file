import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_download_file/flutter_download_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ValueNotifier<String> _state = ValueNotifier("");

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  Future<void> startDownloadImage() async {
    _state.value = "Downloading image...";
    await FlutterDownloadFile().startDownload(
        "https://www.xda-developers.com/files/2018/02/Flutter-Framework-Feature-Image-Background-Colour.png");
    _state.value = "Download done image!";
  }

  Future<void> startDownloadPdf() async {
    _state.value = "Downloading file...";
    await FlutterDownloadFile()
        .startDownload("https://www.orimi.com/pdf-test.pdf");
    _state.value = "Download done file!";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: () {
                  startDownloadImage();
                },
                child: const Text("Download image"),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  startDownloadPdf();
                },
                child: const Text("Download pdf"),
              ),
              const SizedBox(
                height: 50,
              ),
              ValueListenableBuilder<String>(
                  valueListenable: _state,
                  builder: (context, value, child) => Text(value))
            ],
          ),
        ),
      ),
    );
  }
}
