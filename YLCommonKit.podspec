#
#  Be sure to run `pod spec lint YLCommonKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "YLCommonKit"
    s.version      = "0.1.0"
    s.summary      = "我的基础库"
    s.description  = <<-DESC
                        简单的整理,常用的分类
                    DESC

    s.homepage     = "https://github.com/xyl-private/YLCommonKit"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "村雨灬龑" => "xyl_private@163.com" }

    s.ios.deployment_target = "12.0"

    s.source       = { :git => "https://github.com/xyl-private/YLCommonKit.git", :tag => "#{s.version}" }
    s.frameworks = "Foundation","UIKit"

    s.subspec 'YLCategory' do |ss|
        ss.source_files = 'YLCommonKit/YLCategory/*.{h,m}'
        ss.public_header_files = 'YLCommonKit/YLCategory/*.h'
        
        ss.subspec 'Foundation' do |ss|
            ss.source_files = 'YLCommonKit/YLCategory/Foundation/*.{h,m}'
            ss.public_header_files = 'YLCommonKit/YLCategory/Foundation/*.h'
        end

        ss.subspec 'UIKit' do |ss|
            ss.source_files = 'YLCommonKit/YLCategory/UIKit/*.{h,m}'
            ss.public_header_files = 'YLCommonKit/YLCategory/UIKit/*.h'
        end
    end

end
