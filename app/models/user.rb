class User < ActiveRecord::Base
  attr_accessible :email, 
  :username, 
  :nickname, 
  :realname, 
  :mobile, 
  :password, 
  :salt, 
  :province, 
  :city, 
  :site,
  :resume, 
  :domain, 
  :profession, # 职业
  :duty, 
  :gender, 
  :warrant, # 授权
  :bg,
  :bg_repeat, 
  :remember_me,
  :messages_count,
  :nocices_count,
  :del

  has_one :de, as: :source
  has_one :avatar, through: :de, source: :image
  has_many :images
  has_many :albums
  has_many :events
  
  has_many :notices
  # 收件箱 & 发件箱 名义没有发件箱
  has_many :iboxs, class_name: 'Talk', conditions: {del: false}
  # 未读
  has_many :unreads, class_name: 'Talk', conditions: {state: 1, del: false}
  # 已读
  has_many :reads, class_name: 'Talk', conditions: {state: 0, del: false}
  # 垃圾
  has_many :trashs, class_name: 'Talk', conditions: 'state != 0 and state != 1 and del = 0'
  

  WARRANT = {
    0 => '署名-非商业使用-禁止演绎',
    1 => '署名-非商业使用-相同方式共享',
    2 => '署名-非商业使用',
    3 => '署名-禁止演绎',
    4 => '署名-相同方式共享',
    5 => '署名'
  }
  WARRANTVAL = {
    0 => [1, 2, 3],
    1 => [1, 2, 4],
    2 => [1, 2, 5],
    3 => [1, 3, 5],
    4 => [1, 4, 5],
    5 => [1, 5, 5]
  }
  
  PRIVACY = {
    mobile: 0,
    email: 0,
    realname: 0,
    qq: 0,
    weibo: 0,
    msn: 0,
    local: 0,
    profession: 0,
    commendations: 0, # 赞过的
    recommendations: 0, # 推荐的
    collect: 0, # 收藏的
    likes: 0, # 喜欢的
    posts: 0,
    groups: 0
  }

  PRIVACYI18N = {
    mobile: '手机',
    email: '邮箱',
    realname: '真实姓名',
    qq: 'QQ',
    weibo: '微博',
    msn: 'MSN',
    local: '所在地',
    profession: '职业',
    commendations: '赞过的',
    recommendations: '推荐的',
    collect: '收藏的',
    likes: '喜欢的',
    posts: '日志',
    groups: '圈子'
  }

  PRIVACYVAL = {
    0 => '所有人',
    1 => '关注+粉丝+圈子',
    2 => '我的关注',
    3 => '我的粉丝',
    
  }

  def send_msg(to, text)
    # 发送者发件箱一条
    sendtalk = Talk.find_or_create_by_user_id_and_sender_id(self.id, to.id)
    sendtalk.update_attributes(text: text, state: 0)
    sendtalk.messages.create(text: text, user_id: sendtalk.user_id)

    # 接受者收件箱一条
    jointalk = Talk.find_or_create_by_user_id_and_sender_id(to.id, self.id)
    jointalk.update_attributes(text: text, state: 1)
    jointalk.messages.create(text: text, user_id: jointalk.sender_id)
  end
  # from 注册来源

  # 注册用户默认创建相册(默认相册 头像相册),选择模板
  # 邮箱地址: 515856563@qq.com 修改邮箱 修改密码
  # 图片水印: 左中右(/昵称/账户/mail|第二排http://domain.xx.com)
  # 定义模板: bg
  ###权限相关(auth)
  # 邮件提醒: 被关注,加好友,被回应,被喜欢,被点赞,圈子通过,收到漫信
  # 站内通知: 被关注,加好友,被回应,被喜欢,被点赞,圈子通过,收到漫信
  # 站内漫信: 不接受非 圈子,粉丝,关注者的其他信息
  
  # 公开信息: 电话/邮箱/真实姓名/QQ/weibo/douban/msn/城市/职业
  # 授权类型: 参考kpkpw的图片协议
  ###再考虑
  # 自定义模块: 
  # 编辑器: 富文本编辑器  Markdown编辑器 (使用帮助)
  # 黑名单:
  # friends表(user_id, friend_id, mark) has_many through 朋友关系表
  # feeds表(网站动态)
  # ad(visit, click, title) 暂时不做
  # 站内互动: 允许回应(所有,圈子,好友,粉丝)针对活动/other,允许漫信(所有,圈子,好友,粉丝) 暂时不加

  # TODO 找到paplace 如何转存照片
  # user avatar
  # event logo
  # album page(封面)
  # images user_id, album_id
  # TODO 相册删除就del标识，作品里是不存在删除操作的,那么works任何时候都可以引用image

  # 消息, 通知, 设置相关所有

  # recommendations推荐表
  # profiles个人信息表
  # follows关注表(user_id, follower_id, mark)
  # visits(profile event image album group)最新访问表(user_id, visit_id, mark) 
  # works作品表image_id event_id user_id
  # micro 动态表
  
  # topics 游记，日志表
  # comments 针对这些资源回应(post/events/image/Dt)

  # albums用户相册表(name, user_id, auth(only_self, group, follow, group_and_follow, all), page(封面) through:dy)
  # images 图片表(包括avatar)
  # image_groups图片组表(user_id,event_id,content(描述))
  # De 各种资源表(活动之类的)
  # tags 图片标签表(ok)
  # like_tags(user_id, tag_id) 感兴趣的标签
  # events 活动表
  # partners活动参加者表(如果不需要可以挪到des表中)
  # groups圈子表(name, desc, user_id, visits_count, events_count, members_count, permission(公开 被搜索))
  # group users(user_id, group_id, auth(创建 管理 成员)) 圈子用户中间表
  # account 第三方登陆用户表
  # sites(type,type_id,image_id)
  # 其余设置，尽量redis banner 登陆注册页背景图template
  # logs统计
  # 其他


end
