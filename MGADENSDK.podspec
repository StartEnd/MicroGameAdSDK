#
# Be sure to run `pod lib lint MGADENSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  # 库名称
  s.name             = 'MGADENSDK'
  # 版本
  s.version          = '1.0.10'
  # 简介
  s.summary          = '微游戏广告SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

# 开源库描述
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  # 开源库地址
  s.homepage         = 'https://github.com/StartEnd/MicroGameAdSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # 开源协议
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  # 开源作者
  s.author           = { 'Mr.Song' => '996982027@qq.com' }
  #开源库GitHub的路径与tag值，GitHub路径后必须有.git,tag实际就是上面的版本
  s.source           = { :git => 'https://github.com/StartEnd/MicroGameAdSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  # 开源库最低支持版本
  s.ios.deployment_target = '10.0'
  
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'arm64 arm64e armv7 armv7s x86_64' }
  
  #源库资源文件
  #s.source_files = 'MGADENSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MGADENSDK' => ['MGADENSDK/Assets/*.png']
  # }
  # 依赖的自己的Framework
  s.vendored_frameworks ='MGADENSDK/MGADENSDK.framework'

  s.public_header_files = 'Pod/Classes/**/*.h'
  
  s.prefix_header_contents = '#define MGADENSDKCOCOAPODS'
  # 依赖系统库
  # s.frameworks = 'UIKit', 'Foundation'
  # s.static_framework = true
  # 开源库依赖库
  s.dependency 'Google-Mobile-Ads-SDK'
  s.dependency 'GoogleMobileAdsMediationFacebook'
  s.dependency 'GoogleMobileAdsMediationUnity'
  s.dependency 'GoogleMobileAdsMediationIronSource'
  s.dependency 'GoogleMobileAdsMediationAppLovin'
  # s.dependency 'AppLovinSDK'
  # s.dependency 'GoogleMobileAdsMediationVungle'
  # s.dependency 'GoogleMobileAdsMediationTapjoy'
  s.dependency 'GoogleMobileAdsMediationChartboost'


end
