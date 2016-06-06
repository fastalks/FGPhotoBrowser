Pod::Spec.new do |s|
s.name             = 'FGPhotoBrowser'
s.version          = '0.1.0'
s.summary          = 'FGPhotoBrowser is 一个图片浏览器.'

s.description      = <<-DESC
FGPhotoBrowser is 一个图片浏览器，支持本地图片和网络图片的显示.
DESC

s.homepage         = 'https://github.com/wangfaguo/FGPhotoBrowser'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'wangfaguo' => '452290424@qq.com' }
s.source           = { :git => 'https://github.com/wangfaguo/FGPhotoBrowser.git', :tag => s.version.to_s }

s.ios.deployment_target = '7.0'
s.public_header_files = 'FGPhotoBrowser/Classes/**/*.h'
s.source_files = 'FGPhotoBrowser/Classes/**/*'
s.resource_bundles = {
'FGPhotoBrowserImages' => ['FGPhotoBrowser/Assets/**/*']
}
s.frameworks = 'UIKit'
s.dependency 'SDWebImage', '~> 3.7.0'
end
