#
# Be sure to run `pod lib lint KXCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KXCategories'
  s.version          = '0.0.2'
  s.summary          = '这是一个开心的category'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/YangShi123/KXCategories'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'YangShi123' => 'shiyawn@163.com' }
  s.source           = { :git => 'https://github.com/YangShi123/KXCategories.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'KXCategories/KXCategories.h'
  
  # s.resource_bundles = {
  #   'KXCategories' => ['KXCategories/Assets/*.png']
  # }

   s.public_header_files = 'Pod/KXCategories.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.subspec 'Foundation' do |foundation|
      foundation.public_header_files = 'KXCategories/Foundation/KXFoundation.h'
      foundation.source_files = 'KXCategories/Foundation/KXFoundation.h'
      foundation.frameworks = 'Foundation'
      
      foundation.subspec 'NSData' do |data|
          data.source_files = 'KXCategories/Foundation/NSData/*.{h,m}'
          end
      foundation.subspec 'NSDate' do |date|
          date.source_files = 'KXCategories/Foundation/NSDate/*.{h,m}'
          end
      foundation.subspec 'NSString' do |string|
          string.source_files = 'KXCategories/Foundation/NSString/*.{h,m}'
          end
      end
  
  s.subspec 'UIKit' do |uikit|
      uikit.public_header_files = 'KXCategories/UIKit/KXUIKit.h'
      uikit.source_files = 'KXCategories/UIKit/KXUIKit.h'
      uikit.frameworks = 'UIKit'
      
      uikit.subspec 'UIButton' do |button|
          button.source_files = 'KXCategories/UIKit/UIButton/*.{h,m}'
          end
      uikit.subspec 'UIBarButtonItem' do |barButtonItem|
          barButtonItem.source_files = 'KXCategories/UIKit/UIBarButtonItem/*.{h,m}'
          end
      uikit.subspec 'UIColor' do |color|
          color.source_files = 'KXCategories/UIKit/UIColor/*.{h,m}'
          end
      uikit.subspec 'UIDevice' do |device|
          device.source_files = 'KXCategories/UIKit/UIDevice/*.{h,m}'
          end
      uikit.subspec 'UIImage' do |image|
          image.source_files = 'KXCategories/UIKit/UIImage/*.{h,m}'
          end
      uikit.subspec 'UINavigationController' do |navigationController|
          navigationController.source_files = 'KXCategories/UIKit/UINavigationController/*.{h,m}'
          end
      uikit.subspec 'UIView' do |view|
          view.source_files = 'KXCategories/UIKit/UIView/*.{h,m}'
          end
      end
end
