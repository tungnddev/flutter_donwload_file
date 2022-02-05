import Flutter
import UIKit

public class SwiftFlutterDownloadFilePlugin: NSObject, FlutterPlugin {
    
    let downloadManger = DownloadManager()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_download_file", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterDownloadFilePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard call.method == "downloadFile" else {
            result(FlutterMethodNotImplemented)
            return
        }
        if let args = call.arguments as? Dictionary<String, Any> {
            if let urlString = args["url"] as? String {
                downloadManger.downloadFile(url: urlString) {
                    resultSave in result(resultSave)
                }
            }
        }
    }
}
