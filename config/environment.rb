# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mp::Application.initialize!
# Date.today.wday 获取今天周几 integer
$site_config = {
    title: '漫拍网- 生活因温暖而美好 - 漫拍网',
    keywords: '漫拍,漫拍网,摄影活动,深度摄影,摄影名家,摄影展览,每天看时间最好的照片,快拍之星,摄影基地,摄影微博,摄影器材,摄影论坛,名家访谈,抢书读,市民摄影节 - ',
    description: '漫拍网，是一个当代图片社区网站，隔三差五发起一些又好玩又温暖，又有点意思又有点意义的各种漫拍活动。 - '
}
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.exmail.qq.com',
    :port => 25,
    :authentication => :login,
    :user_name => 'service@shanpro.com',
    :password => 'mpwang123'
}