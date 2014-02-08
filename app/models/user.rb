class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  attr_accessible :email, 
  :avatar,
  :username, 
  :nickname, 
  :realname, 
  :mobile, 
  :password, 
  :password_confirmation,
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

  StyleRow = {
    original: '500x500>',
    thumb: '200x200#',
    small: '100x100#',
    s50: '50x50#'
  }
  has_attached_file :avatar,
                    styles: Hash[StyleRow.map{|k,v| [k, {geometry: v, quality: :better}]}]

  has_many :images
  has_many :albums
  has_many :events
  has_many :works
  has_many :notices
  has_many :micros
  # 收件箱 & 发件箱 名义没有发件箱
  has_many :iboxs, class_name: 'Talk', conditions: {del: false}
  # 未读
  has_many :unreads, class_name: 'Talk', conditions: {state: 1, del: false}
  # 已读
  has_many :reads, class_name: 'Talk', conditions: {state: 0, del: false}
  # 垃圾
  has_many :trashs, class_name: 'Talk', conditions: 'state != 0 and state != 1 and del = 0'

  # 授权其他网站
  has_many :accounts
  

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
  validates_presence_of     :email, 
                            :message => '邮箱不能为空',
                            :if => :email_changed?

  validates_uniqueness_of   :email, 
                            :message => '邮箱已存在'

  validates_format_of       :email, 
                            :with  => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                            :message => '邮箱格式不正确'

  validates_presence_of     :password,
                            :message => '密码不能为空',
                            :if => :password_changed?

  validates_length_of       :password,
                            :within => 5..32,
                            :message => '长度5..32位'

  validates_confirmation_of :password,
                            :message => "密码不一致",
                            :on => :create

  validates_presence_of     :username,
                            :message => '用户名不能为空'

  validates_uniqueness_of   :username, 
                            :message => '用户名已存在'

  validates_format_of       :username,
                            :with => /[\u4e00-\u9fa5\w]{2,10}$/,
                            :message => "2-10位汉字/字母/数字/_组成"

  validates_format_of       :mobile,
                            :with => /^1[3|4|5|8][0-9]\d{4,8}$/,
                            :allow_blank => true,
                            :message => '手机格式不正确'
  validates_uniqueness_of   :mobile, 
                            :allow_blank => true,
                            :message => '手机已存在'

  validates_format_of       :realname,
                            :with => /[\u4e00-\u9fa5]{2,10}$/,
                            :allow_blank => true,
                            :message => "2-10位汉字"
  
  validates_format_of       :domain,
                            :with => /[\w-]{2,10}$/,
                            :allow_blank => true,
                            :message => "2-10位字母/数字/下划线/横线"

  def send_msg(to, text)
    # 接受者收件箱一条
    jointalk = Talk.find_or_create_by_user_id_and_sender_id(to.id, self.id)
    jointalk.update_attributes(text: text, state: 1)
    jointalk.messages.create(text: text, user_id: jointalk.sender_id)

    # 发送者发件箱一条
    sendtalk = Talk.find_or_create_by_user_id_and_sender_id(self.id, to.id)
    sendtalk.update_attributes(text: text, state: 0)
    sendtalk.messages.create(text: text, user_id: sendtalk.user_id)
  end

  
  after_create :basic_build

  def basic_build
    self.albums.create(name: '默认相册', text: '默认相册', open: 0)
  end

  # 加密
  def password=(new_password)
    write_attribute(:password, Digest::MD5.hexdigest(new_password)) if new_password.present?
  end
  def password_confirmation=(new_password)
    write_attribute(:password_confirmation, Digest::MD5.hexdigest(new_password)) if new_password.present?
  end

  def valid_password?(new_password)
    self.password == Digest::MD5.hexdigest(new_password)
  end

  # 常驻地
  def addr
    province.eql?(city) ? province : province + ' ' + city
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
  ###再考虑
  # 自定义模块: 
  # 编辑器: 富文本编辑器  Markdown编辑器 (使用帮助)
  # 黑名单:
  # friends表(user_id, friend_id, mark) has_many through 朋友关系表
  # feeds表(网站动态)
  # ad(visit, click, title) 暂时不做
  # 站内互动: 允许回应(所有,圈子,好友,粉丝)针对活动/other,允许漫信(所有,圈子,好友,粉丝) 暂时不加

  # TODO 找到 paperclip 如何转存照片
  # TODO paperclip cut
  # TODO 参与活动的照片也瀑布流,全部图片上传解决，相册(logo,创建等)，活动创建解决，瀑布流也可以正常排列,列表排列
  # TODO 其中列表排列时后面是详细的点赞，浏览，喜欢等等乱七八糟的
  # TODO image/show 有evid,woid和currid来决定作品的浏览。 alid和currid来决定相册的浏览, else 一般浏览
  # TODO 怎么让照片成组,这样方便成组浏览,做为活动作品的一个属性想一下: 可以在work表添加group字段来标示某组, 内容用uid和eventid+随机串
  # TODO (如果参加某活动的所有图片都分为一组，那么不需要此字段, 直接活动where eventid group uid就可以了, 同时 相册和作品分开浏览,但原图必须跳转到一个地址)
  # TODO 没有推荐话题,按照评论多少来显示
  # TODO 推荐摄影师按照后台推荐和照片质量
  # TODO 添加照片类型(风光、人文、静物、广告)
  # TODO 相册添加移动功能,达到分组的效果,并且参加活动的时候可以从相册选择照片
  # TODO 创建相册有bug

  # TODO 第三方登陆, 个人设置, 图片上传和作品上传, 分享图片的文字

  # 消息, 通知, 设置相关所有

  # recommendations推荐表
  # profiles个人信息表
  # follows关注表(user_id, follower_id, mark)
  # visits(profile event image album group)最新访问表(user_id, visit_id, mark) 
  
  # micro 动态表
  # push 用户对图片/日志/作品等资源的各种操作 单继承表+多态表
  
  # topics 游记，日志表
  # comments 针对这些资源回应(post/events/image/Dt)

  # tags 图片标签表(ok)
  # like_tags(user_id, tag_id) 感兴趣的标签
  # groups圈子表(name, desc, user_id, visits_count, events_count, members_count, permission(公开 被搜索))
  # group users(user_id, group_id, auth(创建 管理 成员)) 圈子用户中间表
  # account 第三方登陆用户表
  # sites(type,type_id,image_id)
  # 其余设置，尽量redis banner 登陆注册页背景图template
  # logs统计
  # 其他
end
