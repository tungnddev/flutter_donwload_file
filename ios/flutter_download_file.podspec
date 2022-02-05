#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_download_file.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_download_file'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = 'Plugin for downloading file'
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://ridast.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'TungND' => 'tungnd.dev@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
