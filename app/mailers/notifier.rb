# encoding: utf-8
class Notifier < ActionMailer::Base
  default from: '"漫拍网" <service@mpwang.com.cn>'
  # FROM = '"你的博客" <admin@zhuxiaowu.com>'
  # default from: ['"first name" <first@f.com>', '"second name" <second@s.com>']
  
  # 注册验证
  # 找回密码
  # 重置密码通知
  # 全站邮件

  def sign_mail user, forgot = false
    @user = user
    @forgot = forgot
    mail(to: @user.email, :subject => forgot ? "密码找回" : "注册邮件")
  end

  def choice_mail
    mails = [
      "515856563@qq.com",
      "admin@mpwang.com.cn", 
      "1@mpwang.com.cn", 
      "xingcj@126.com", 
      "xingcj@mpwang.com.cn",
      # "593937246@qq.com", # qiufeng
      "545362642@qq.com" #wangning
    ]
    mail(to: mails, subject: Date.today.to_s + "没有精选照片")
  end

end
