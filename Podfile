# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'

target 'Demo500px' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Demo500px
pod 'MBProgressHUD', '~> 1.0.0'
pod 'SwiftyJSON'
pod 'IQKeyboardManagerSwift'
pod 'Kingfisher'
pod 'Fabric'
pod 'Crashlytics'
pod 'Alamofire'

  target 'Demo500pxTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Demo500pxUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['SWIFT_VERSION'] = '3.0'
end
end
end
