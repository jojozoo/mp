class User < ActiveRecord::Base
  attr_accessible :city, :email, :mobile, :nickname, :password, :province, :remember_me, :salt, :username, :resume, :domain

  # profile页 个人资料(职业/gender/duty) 头像 相册 时间轴

# 邮箱地址: 515856563@qq.com 修改邮箱 修改密码
# 编辑器 富文本编辑器  Markdown编辑器 (使用帮助)
# 邮件提醒:被人关注,收到投稿,收到私信,点点周刊,博客数据周刊
# 站内消息: 加好友，同意好友，被回应，被喜欢，被赞等等
# 自定义模板: 找几个图
# 自定义模块: 再考虑
# 黑名单 导入 / 导出 删除帐号
# 个性域名
# 互动设置: 允许回应(所有，圈子，好友，粉丝)，允许私信(所有，圈子，好友，粉丝)
# 图片水印: 左中右(/昵称/账户/mail|第二排http://domain.xx.com)
# 原创内容授权: (参考kpkpw的图片协议)
  
  # profile 表 个人信息

  # followship表 follow关系

  # friendship表 朋友关系表 是否需要,再议

  # visit 最新访问

  # auth 用户公开权限表，例如电话,相册其他之类的,邮件提醒,消息,follow是否发邮件

  # notice 网站通知表 title, content tag(网站,全部用户,圈子,特定用户(相册超过多少等等)) after_create
  # notice_user user_id read(true/false)

  # message 私信消息表 from_id to_id tag(已读/未读/垃圾) content after_create(创建发送)

  # post 游记，日志表

  # comments 针对这些资源回应(post/events/image/Dy)

  # album 用户相册表

  # images 图片表(包括avatar)

  # Dy 各种资源表(活动之类的)

  # tags 图片标签表

  # like tags 感兴趣的标签

  # events 活动表

  # group 圈子表

  # group users 圈子用户中间表

  # account 第三方登陆用户表

  # feed表(网站动态)

  # ad(visit, click, title) 暂时不做

  # 其余设置，尽量redis banner 登陆注册页背景图

  # 统计 其他


end
