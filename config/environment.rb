# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mp::Application.initialize!
# Date.today.wday 获取今天周几 integer
$site_config = {
    title: '漫拍网 - 源自生活的影像',
    keywords: '漫拍,漫拍网,mp,mpwang,图片,摄影,摄影师,摄影活动,深度摄影,摄影名家,商业摄影,影览,图片分享,照片,照片分享,摄影界,图片下载,艺术墙,亲情,图片组合',
    description: '漫拍网是一个倡导拍身边人,身边事,身边景的社交网站,用照片记录生活面貌,表现社会发展进程,表达内心感悟.漫即广泛、深远、悠闲,拍即呈现我们身边的影像,让我们一起分享镜头中的精彩.'
}
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.exmail.qq.com',
    :port => 25,
    :authentication => :login,
    :user_name => 'service@mpwang.com.cn',
    :password => 'mpwang123'
}
