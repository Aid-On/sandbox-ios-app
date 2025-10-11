# Uncomment the next line to define a global platform for your project
platform :ios, ENV['XCODE_DEPLOYMENT_TARGET']

target 'App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Modern iOS Pods
  pod "Alamofire", "~> 5.8"
  pod "SwiftyJSON", "~> 5.0"
  pod "Kingfisher", "~> 7.0"

  target 'AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'AppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = ENV['XCODE_DEPLOYMENT_TARGET']
    end
  end
end
