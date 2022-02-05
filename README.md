# Flutter Download File
A flutter plugin for downloading files. Just support Android and iOS.\
With android, this plugin use [Download Manager](https://developer.android.com/reference/android/app/DownloadManager).
With iOS, this plugin will auto save image to Photos (if file is image) or show `Save to file` dialog if file is the others.\
![](/images/share.png)

## iOS integration
Add description to save image to photos (add following codes to `Infor.plist` file)
```

<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need access to photo library so that photos can be download</string>

```
## Usage
#### Import package:
```

import 'package:flutter_download_file/flutter_download_file.dart';

```
#### Start download:
```

// show loading
await FlutterDownloadFile(
        androidSettings: AndroidDownloadSetting(isShowNotification: true)     //optional
      ).startDownload('your url file');
// hide loading

```

## Bugs/Requests
If you encounter any problems feel free to open an issue. If you feel the library is missing a feature, please raise a ticket on Github. Pull request are also welcome.



