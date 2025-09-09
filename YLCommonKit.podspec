#
#  Be sure to run `pod spec lint YLCommonKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    # 项目名
    s.name         = "YLCommonKit"
    # 版本号
    s.version      = "0.1.4"
    # 简单描述
    s.summary      = "我的基础库"
    # 详细描述
    s.description  = <<-DESC
                        简单整理常用的分类
                        DESC
    # 项目的主页
    s.homepage     = "https://github.com/xyl-private/YLCommonKit"
    # 项目遵守的协议
    s.license      = { :type => "MIT", :file => "LICENSE" }
    # 作者的邮箱
    s.author       = { "村雨灬龑" => "xyl_private@163.com" }
    # 项目的最低版本支持
    s.ios.deployment_target = "13.0"
    # git仓库的https地址
    s.source       = { :git => "https://github.com/xyl-private/YLCommonKit.git", :tag => "#{s.version}" }
    s.frameworks = "Foundation","UIKit"

    # 表示源文件的路径，这个路径是相对podspec文件而言的。（这属性下面单独讨论）
    s.source_files = 'YLCommonKit/YLCategory/*.{h,m}'
    s.public_header_files = 'YLCommonKit/YLCategory/*.h'
       
    s.subspec 'Macro' do |ss|
        ss.source_files = 'YLCommonKit/YLCategory/Macro/*.{h,m}'
        ss.public_header_files = 'YLCommonKit/YLCategory/Macro/*.h'
    end
    s.subspec 'Foundation' do |ss|
        ss.source_files = 'YLCommonKit/YLCategory/Foundation/*.{h,m}'
        ss.public_header_files = 'YLCommonKit/YLCategory/Foundation/*.h'
    end
    s.subspec 'UIKit' do |ss|
        ss.source_files = 'YLCommonKit/YLCategory/UIKit/*.{h,m}'
        ss.public_header_files = 'YLCommonKit/YLCategory/UIKit/*.h'
    end

end
