# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TinkoffFintechChat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TinkoffFintechChat
pod 'Firebase/Firestore'
pod 'SwiftLint'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

target 'ChatTests' do
inherit! :search_paths
#pod 'Firebase/firestore'
end

target "ChatUITests" do
  use_frameworks!
  pod 'iOSSnapshotTestCase'
end

end


