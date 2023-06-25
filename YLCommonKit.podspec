#
#  Be sure to run `pod spec lint YLCommonKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

    s.name         = "YLCommonKit"
    s.version      = "0.0.28"
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
        
        ss.subspec 'YLFoundation' do |ss|
            ss.subspec 'Other' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/Other/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/Other/*.h'
            end
            ss.subspec 'NSData' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/NSData/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/NSData/*.h'
            end
            ss.subspec 'NSString' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/NSString/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/NSString/*.h'
            end
            ss.subspec 'NSDate' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/NSDate/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/NSDate/*.h'
            end
            ss.subspec 'NSAttributedString' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/NSAttributedString/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/NSAttributedString/*.h'
            end
            ss.subspec 'NSLog' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/NSLog/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/NSLog/*.h'
            end
            ss.subspec 'NSDictionary' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLFoundation/NSDictionary/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLFoundation/NSDictionary/*.h'
            end
        end

        ss.subspec 'YLUIKit' do |ss|
            ss.subspec 'UIImage' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UIImage/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UIImage/*.h'
            end

            ss.subspec 'UIButton' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UIButton/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UIButton/*.h'
            end

            ss.subspec 'UIColor' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UIColor/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UIColor/*.h'
            end

            ss.subspec 'UIFont' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UIFont/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UIFont/*.h'
            end

            ss.subspec 'UIView' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UIView/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UIView/*.h'
            end

            ss.subspec 'UITextView' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UITextView/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UITextView/*.h'
            end

            ss.subspec 'UIViewController' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UIViewController/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UIViewController/*.h'
            end

            ss.subspec 'UITableView' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UITableView/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UITableView/*.h'
            end

            ss.subspec 'UITextField' do |ss|
                ss.source_files = 'YLCommonKit/YLCategory/YLUIKit/UITextField/*.{h,m}'
                ss.public_header_files = 'YLCommonKit/YLCategory/YLUIKit/UITextField/*.h'
            end

        end
    end

end
