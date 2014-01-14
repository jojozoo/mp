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
  :del

  has_one :de, as: :source
  has_one :avatar, through: :de, source: :image

  WARRANT = {
    0 => '署名',
    1 => '署名-禁止演绎',
    2 => '署名-非商业性使用-禁止演绎',
    3 => '署名-非商业性使用',
    4 => '署名-非商业性使用-相同方式共享',
    5 => '署名-相同方式共享'
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
  # from 注册来源
  # profile页 基本资料 头像(在Dt下) 相册 作品 时间轴 粉丝 关注 日志 游记 圈子 活动 点赞 推荐 喜欢 收藏 同步其他网站
  # attr 

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

  # recommendations推荐表
  # profiles个人信息表
  # follows关注表(user_id, follower_id, mark)
  # visits(profile event image album group)最新访问表(user_id, visit_id, mark) 
  # works作品表image_id event_id user_id
  # timeline时间轴表(user_id)
  # site_sends全站邮件/通知/漫信表(title/content/state/end_time) after_create(nodejs)
  # state: 网站(网页显示),全部用户,xx圈子,特定用户(相册超过多少等等)
  # notice网站通知表(user_id site_sends_id title content read(true/false))
  # message 漫信消息表 from_id to_id state(已读/未读/垃圾) content after_create(创建发送)
  
  # posts 游记，日志表
  # comments 针对这些资源回应(post/events/image/Dt)

  # albums用户相册表(name, user_id, auth(only_self, group, follow, group_and_follow, all), page(封面) through:dy)
  # images 图片表(包括avatar)
  # De 各种资源表(活动之类的)
  # tags 图片标签表(ok)
  # like_tags(user_id, tag_id) 感兴趣的标签
  # events(title, content, user_id活动发起类型(官方,用户), end_time, pic(关联image), partners_count(参加者),pics_count, state(未通过 进行中 已结束)) 活动表
  # partners参加者(event_id,user_id,winner活动获奖用户, level(名次))
  # groups圈子表(name, desc, user_id, visits_count, events_count, members_count, permission(公开 被搜索))
  # group users(user_id, group_id, auth(创建 管理 成员)) 圈子用户中间表
  # account 第三方登陆用户表
  # sites(type,type_id,image_id)
  # 其余设置，尽量redis banner 登陆注册页背景图template
  # logs统计
  # 其他


end
