Pod::Spec.new do |s|
        s.name         = "YLCommonKit"
        s.version      = "0.0.4"
        s.summary      = "我的基础库"
        s.homepage     = "https://github.com/xyl-private/YLCommonKit"
        s.license      = { :type => "MIT", :file => "LICENSE" }
        s.author       = { "村雨灬龑" => "xyl-private@163.com" }

        s.ios.deployment_target = "8.0"
        s.source       = { :git => "https://github.com/xyl-private/YLCommonKit.git", :tag => "#{s.version}" }

        s.requires_arc = true
        s.source_files = 'YLCommonKit/**/*.{h,m}'

        s.subspec 'YLNetworking' do |httpManager|
            httpManager.source_files = 'YLCommonKit/YLNetworking/*.{h,m}'
            httpManager.public_header_files = 'YLCommonKit/YLNetworking/*.h'

            httpManager.dependency 'AFNetworking'
            httpManager.dependency 'Reachability'
            httpManager.dependency 'YYModel'
        end

end

