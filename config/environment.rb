# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mp::Application.initialize!
# Date.today.wday 获取今天周几 integer
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.exmail.qq.com',
    :port => 25,
    :authentication => :login,
    :user_name => 'service@mpwang.com.cn',
    :password => 'mpwang123'
}
