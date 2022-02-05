//
//  String+Extensions.swift
//  flutter_download_file
//
//  Created by TungND on 2/4/22.
//

import Foundation

extension String {
    var isImage: Bool {
        return self.contains(".png") || self.contains(".jpg") || self.contains(".jpeg")
    }
    
    var isDriveFile: Bool {
        return self.contains(".doc") || self.contains(".xlxs") || self.contains(".pdf")
    }
}
