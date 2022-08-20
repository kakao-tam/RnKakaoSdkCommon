#
# Be sure to run `pod lib lint RnKakaoSdkCommon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RnKakaoSdkCommon'
  s.version          = '1.0.0'
  s.summary          = 'React Native KakaoSDK Common - KakaoTam'
  s.description      = 'React Native KakaoSDK Common - KakaoTam, This library is used only with the React Native KakaoSDK module.'
  s.homepage         = 'https://github.com/kakao-tam/RnKakaoSdkCommon'
  s.license          = { :type => 'None', :file => 'LICENSE' }
  s.author           = { 'wisdomcdh' => 'wisdomcdh@gmail.com' }
  s.source           = { :git => 'https://github.com/kakao-tam/RnKakaoSdkCommon.git', :tag => s.version.to_s }
  s.swift_version = '4.0'

  s.ios.deployment_target = '11.0'

  s.source_files = 'RnKakaoSdkCommon/Classes/**/*'

  s.dependency 'KakaoSDKCommon'
  s.dependency 'KakaoSDKTemplate'
end
