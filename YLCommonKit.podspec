Pod::Spec.new do |s|
        s.name         = "YLCommonKit"
        s.version      = "0.0.4"
        s.summary      = "我的基础库"
        s.homepage     = "https://github.com/xyl-private/YLCommonKit"
        s.license      = { :type => "MIT", :file => "LICENSE" }
        s.author       = { "村雨灬龑" => "xyl-private@163.com" }

        s.ios.deployment_target = "8.0"
        s.source       = { :git => "https://github.com/xyl-private/YLCommonKit.git", :tag => "#{s.version}" }

        s.source_files = 'YLCommonKit/**/*.{h,m}'
        s.public_header_files = 'YLCommonKit/**/*.h'

end

