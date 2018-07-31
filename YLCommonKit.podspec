#
#  Be sure to run `pod spec lint YLCommonKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "YLCommonKit"
    s.version      = "0.0.4"
    s.summary      = "我的基础库"
    s.description  = <<-DESC
                    DESC

    s.homepage     = "https://github.com/xyl-private/YLCommonKit"
    s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author       = { "村雨灬龑" => "xyl-private@163.com" }

    s.ios.deployment_target = "9.0"

    s.source       = { :git => "https://github.com/xyl-private/YLCommonKit.git", :tag => "#{s.version}" }

    s.source_files  = "YLCommonKit", "YLCommonKit/**/*.{h,m}"
    s.public_header_files = "YLCommonKit/**/*.h"

    s.subspec 'YLMacro' do |ss|
        ss.source_files = 'YLMacro/*.{h,m}'
        ss.public_header_files = 'YLMacro/*.h'
    end

    s.subspec 'YLCategory' do |ss|
        ss.source_files = 'YLCategory/**/*.{h,m}'
        ss.public_header_files = 'YLCategory/**/*.h'
    end
end
