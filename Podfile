  source 'https://cdn.cocoapods.org/'
  platform :ios, '13.0'

target 'TennisMoment' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TennisMoment

  pod 'SnapKit', '~> 5.0.0'
  pod 'TABAnimated', '2.5.1'
  pod 'TMComponent', :git => 'https://github.com/RoyJoel/TMComponent.git', :tag => '0.6.0'
  pod 'Alamofire'
  pod 'Toast-Swift'
  pod 'SwiftyJSON'
  pod 'SwiftFormat/CLI', '0.40.4'
  pod 'TABAnimated', '2.5.1'
  pod 'JXSegmentedView'
  pod 'Starscream'
  pod 'ReachabilitySwift'


  target 'TennisMomentTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TennisMomentUITests' do
    # Pods for testing
  end

end

    post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
          end
        end
      end
    end

