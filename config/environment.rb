# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mp::Application.initialize!
# Date.today.wday 获取今天周几 integer
$site_config = {
    title: '漫拍网 - 生活因温暖而美好',
    keywords: '漫拍,漫拍网,mp,mpwang,图片,摄影,摄影师,摄影活动,深度摄影,摄影名家,商业摄影,影览,图片分享,照片,照片分享,摄影界,图片下载,艺术墙,亲情,图片组合',
    description: '漫拍网,是一个当代图片社区网站,隔三差五发起一些好玩又温暖,有点意思又有点意义的摄影活动'
}
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.exmail.qq.com',
    :port => 25,
    :authentication => :login,
    :user_name => 'service@shanpro.com',
    :password => 'mpwang123'
}