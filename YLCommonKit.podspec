#
#  Be sure to run `pod spec lint YLCommonKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  # 框架名字：框架名字一定要写对，pod search "框架名"就是搜的这个
  s.name         = "YLCommonKit"
  # 框架版本号
  s.version      = "0.0.1"
  # 框架简介
  s.summary      = "我的基础库"
  # 框架秒数
  s.description  = <<-DESC
  							简单的 kit 存放各种常用的分类方法
                   DESC
  # 框架的主页
  s.homepage     = "https://github.com/xyl-private/YLCommonKit"
  # 框架遵守的开源协议
	s.license= { :type => "MIT", :file => "LICENSE" }
	# 框架的作者
  s.author       = { "村雨灬龑" => "xyl-private@163.com" }

 	s.ios.deployment_target = "9.0"
 	#框架的资源路径：路径可以指向远端代码库，也可以指向本地项目，例如：
  #                   1.指向远端代码库： { :git => "git@git.oschina.net:yoowei/yoowei.git", :tag => "1.0.0" }
  #                   2.指向本地项目：    { :path => 'yoowei', }
  s.source       = { :git => "https://github.com/xyl-private/YLCommonKit.git", :tag => "#{s.version}" }
	# 框架被其他工程引入时，会导入Classes目录下的.h和.m文件
  s.source_files  = "Classes", "YLCommonKit/Classes/**/*.{h,m}"
	# 框架依赖的framework
	s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage', 'QuartzCore', 'ImageIO', 'AssetsLibrary', 'Accelerate', 'MobileCoreServices', 'SystemConfiguration', 'WebKit','CoreLocation'

	# 框架依赖的其他第三方库
end

