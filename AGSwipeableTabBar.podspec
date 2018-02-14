#
# Be sure to run `pod lib lint AGSwipeableTabBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AGSwipeableTabBar'
  s.version          = '0.1.0'
  s.summary          = 'AGSwipeableTabBar is use for swipeable Tab bar. which is directly used by assign class into the view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: AGSwipeableTabBar use for swipeable Tab bar. This swipeable tab bar is created by the use of collection views and have lots of features. This swipeable Tab bar is directly used by add file into view.
                       DESC

  s.swift_version      = '4.0'
  s.homepage         = 'https://github.com/DeveloperFly/AGSwipeableTabBar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aman gupta' => 'aman19ish@gmail.com' }
  s.source           = { :git => 'https://github.com/DeveloperFly/AGSwipeableTabBar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AGSwipeableTabBar/Classes/**/*'
  
  s.resource_bundles = {
    'AGSwipeableTabBar' => ['AGSwipeableTabBar/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
