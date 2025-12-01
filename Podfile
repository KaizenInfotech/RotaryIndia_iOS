# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'TouchBase' do

end

target 'TouchBaseTests' do

end

target 'TouchBaseUITests' do
end

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘9.0’



pod 'SVProgressHUD'
pod 'IQKeyboardManagerSwift'
pod 'GoogleMaps'
#pod 'Google/Analytics'
pod 'Alamofire'
#pod 'LiquidFloatingActionButton'
#pod 'Kingfisher', '~> 2.4'
#pod 'xmpp-messenger-ios'
pod 'PEAR-ImageSlideViewer-iOS'
pod "MWPhotoBrowser"
#pod "WYChart"
#pod 'DatePickerCell'
#pod 'DatePickerDialog'
#pod 'SJSegmentedScrollView'
pod 'SJSegmentedScrollView', '1.3.6'
#pod 'WPZipArchive'
pod 'SSZipArchive'
pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'Firebase/DynamicLinks'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'Firebase/RemoteConfig'
pod 'Firebase/InAppMessaging'
pod 'Firebase/Analytics'
pod 'SDDownloadManager'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end
