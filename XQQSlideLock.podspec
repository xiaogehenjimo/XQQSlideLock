Pod::Spec.new do |s|
//文件名
s.name = 'XQQSlideLock'
//版本
s.version = '1.0'
//描述信息
s.summary = 'A view slideLock on iOS.'
//这里的主页自己随便写
s.homepage = 'www.uipower.com' 
//作者
s.authors = { 'xu19921225' => 'xuqinqiang666@126.com' }
//资源路径
s.source = { :git => 'https://github.com/xiaogehenjimo/XQQSlideLock.git', :tag => '1.0' }
//ARC模式
s.requires_arc = true
//license，一般我们用MIT
s.license = 'Apache'
//允许的最低系统使用版本
s.ios.deployment_target = '8.0'
//库文件路径
s.source_files = 'XQQSlideLock/*'
end
