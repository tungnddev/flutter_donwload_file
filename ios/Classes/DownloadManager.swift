//
//  DownloadManager.swift
//  flutter_download_file
//
//  Created by TungND on 2/4/22.
//
import Foundation

class DownloadManager {
    
    func downloadFile(url: String, result: @escaping (Bool) -> ()) {
        if (url.isImage) {
            getData(from: URL(string: url)!) { data, response, error in
                guard let data = data, error == nil else {
                    result(false)
                    return
                }
                DispatchQueue.main.async() { [] in
                    guard let uiImage = UIImage(data: data) else {
                        result(false)
                        return
                    }
                    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                    result(true)
                }
            }
        } else {
            downloadFile(urlString: url, callback: result)
        }
        
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadFile(urlString: String, callback: @escaping (Bool) -> ()) {
        let url = URL(string: urlString)
        let fileName = String((url!.lastPathComponent)) as NSString
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(fileName)")
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL!)
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                    do {
                        if (FileManager.default.fileExists(atPath: destinationFileUrl.path)) {
                            try FileManager.default.removeItem(at: destinationFileUrl)
                        }
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    } catch (let err) {
                        print(err)
                        callback(false)
                    }
                    DispatchQueue.main.async{
                        do {
                            try self.showSaveDialog(destinationFileUrl: destinationFileUrl)
                            callback(true)
                        } catch {
                            print("Cannot show save dialog")
                            callback(false)
                        }
                    }
                } else {
                    print("Download file fail with status code nil")
                    callback(false)
                }
            } else {
                print("Cannot download with url \(urlString)")
                callback(false)
            }
        }
        task.resume()
    }
    
    private func showSaveDialog(destinationFileUrl: URL) throws {
        let documentsUrl = destinationFileUrl.deletingLastPathComponent()
        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        for indexx in 0..<contents.count {
            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                if !(UIApplication.topViewController() is UIAlertController) {
                    UIApplication.topViewController()!.present(activityViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
