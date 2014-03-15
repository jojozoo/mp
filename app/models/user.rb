# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string(255)
#  username            :string(255)
#  nickname            :string(255)
#  realname            :string(255)
#  mobile              :string(255)
#  password            :string(255)
#  salt                :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  province            :string(255)
#  city                :string(255)
#  site                :string(255)
#  resume              :string(255)
#  domain              :string(255)
#  profession          :string(255)
#  duty                :date
#  gender              :boolean
#  warrant             :integer          default(5)
#  admin               :boolean          default(FALSE)
#  photographer        :boolean          default(FALSE)
#  talks_count         :integer          default(0)
#  notices_count       :integer          default(0)
#  followers_count     :integer          default(0)
#  bg                  :string(255)      default("/images/defaults/bgs.jpg")
#  repeat              :string(255)      default("repeat")
#  remember_me         :string(255)
#  del                 :boolean          default(FALSE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

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
  :repeat, 
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
  has_many :pushes

  has_many :tuilauds, as: :obj
  has_many :tuilikes, as: :obj
  has_many :tuistores, as: :obj
  has_many :tuirecoms, as: :obj
  
  # 我的关注(我关注的人)
  has_many :follow_ships, class_name: 'Follow', foreign_key: :follower_id
  has_many :follows, source: :user, through: :follow_ships
  # 关注我的(我的关注者)
  has_many :follower_ships, class_name: 'Follow', foreign_key: :user_id
  has_many :followers, source: :user, through: :follower_ships

  has_many :topics
  has_many :push_images
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
  
  
  validates_presence_of     :email, 
                            :message => '不能为空',
                            :if => :email_changed?

  validates_uniqueness_of   :email, 
                            :message => '邮箱已存在'

  validates_format_of       :email, 
                            :with  => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                            :message => '邮箱格式不正确'

  validates_presence_of     :password,
                            :message => '不能为空',
                            :if => :password_changed?

  validates_length_of       :password,
                            :within => 5..32,
                            :message => '长度5..32位'

  validates_confirmation_of :password,
                            :message => "密码不一致",
                            :on => :create

  validates_presence_of     :username,
                            :message => '不能为空'

  validates_uniqueness_of   :username, 
                            :message => '帐户已存在'

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

  def send_msg(to, content)
    # 接受者收件箱一条
    jointalk = Talk.find_or_create_by_user_id_and_sender_id(to.id, self.id)
    jointalk.update_attributes(content: content, state: 1)
    jointalk.messages.create(content: content, user_id: jointalk.sender_id)

    # 发送者发件箱一条
    sendtalk = Talk.find_or_create_by_user_id_and_sender_id(self.id, to.id)
    sendtalk.update_attributes(content: content, state: 0)
    sendtalk.messages.create(content: content, user_id: sendtalk.user_id)
  end

  
  after_create :basic_build
  before_save  :check_not_v_attr

  def basic_build
    self.albums.create(name: '默认相册')
  end

  def check_not_v_attr
    # 之前有值,但还想再次改变 domain_change
    self.domain = domain_was if domain_was.present? and domain_changed?
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

  # 针对group是否能发布
  def speak?(group)
    gid = group.is_a?(Group) ? group.id : group
    members.exists?(group_id: gid)
  end

  # from 注册来源
  # 修改邮箱 修改密码
  # 图片水印: 左中右(/昵称/帐户/mail|第二排http://domain.xx.com)
  ###权限相关(auth)
  # 邮件提醒: 被关注,加好友,被回应,被喜欢,被点赞,收到漫信
  # 站内通知: 被关注,加好友,被回应,被喜欢,被点赞,收到漫信
  ###再考虑
  # 编辑器: 富文本编辑器  Markdown编辑器 (使用帮助)
  # friends表(user_id, friend_id, mark) has_many through 朋友关系表
  # feeds表(网站动态)
  # 站内互动: 允许回应(所有,好友,粉丝)针对活动/other,允许漫信(所有,好友,粉丝) 暂时不加

  # TODO 参与活动的图片也瀑布流,全部图片上传解决，相册(logo,创建等)，瀑布流也可以正常排列,列表排列
  # TODO 其中列表排列时后面是详细的点赞，浏览，喜欢等等乱七八糟的
  # TODO image/show 有evid,woid和currid来决定作品的浏览。 alid和currid来决定相册的浏览, else 一般浏览
  # TODO 怎么让图片成组,这样方便成组浏览,做为活动作品的一个属性想一下: 可以在work表添加group字段来标示某组, 内容用uid和eventid+随机串
  # TODO (如果参加某活动的所有图片都分为一组，那么不需要此字段, 直接活动where eventid group uid就可以了, 同时 相册和作品分开浏览,但原图必须跳转到一个地址)
  # TODO 没有推荐话题,按照评论多少来显示
  # TODO 推荐摄影师按照后台推荐和图片质量
  # TODO 添加图片类型(风光、人文、静物、广告)
  # TODO 相册添加移动功能,达到分组的效果,并且参加活动的时候可以从相册选择图片
  # TODO 系统方面 数据备份 日志切割 日志分析 进程监控
  # TODO
  # 瀑布流加载
  # 如果micros中的相册删除掉，就显示已删除
  # image show页面 两种方式
  # 1 活动跳转到本页         标题显示活动名称
  # 2 图库或者相册跳转到本页  显示相册名称
  # TODO /gs/1 分享图片的文字
  # simple_form boolean bootstrap validate
  # 作品展示参考例子
  # http://www.wookmark.com/image/375537/fireworks-by-gaudibuendia-d70nozr-jpg-image-jpeg-1249-639-pixels
  # 幻灯片带底部缩略图展示插件
  # fancyBox,flare,prettyphoto
  # http://doc.bropaul.com/fancyBox/
  # http://www.fancyapps.com/fancybox/ 缩略图并不好看, 但可以参照付费的flare调整缩略图
  # http://pixelentity.com/previews/components/flare/
  # http://www.no-margin-for-errors.com/projects/prettyphoto-jquery-lightbox-clone/ 缩略图也是可参考的
  # http://www.itivy.com/jquery/archive/2011/7/2/jquery-image-player-prettyphoto-usage.html

  # TODO
  # 日志切割
  # http://zhuxiaowu.com/jyuaEj
  # 日志分析
  # 要中文化,之后存入到数据库,方便生成图表
  # https://github.com/wvanbergen/request-log-analyzer
  # 图表分析
  # http://www.highcharts.com/

  # tuis推荐表 推荐里面有个score来判断此图或者资源的分数, score应该是被推荐的对象
  # push 用户对图片/作品等资源的各种操作 单继承表+多态表 push 和 tui 没什么区别呢
  # follows关注表(user_id, follower_id, mark)
  # visits(profile event image album group)最新访问表(user_id, visit_id, mark)
  # essence 摄影师作品 用于摄影师的优秀作品集合
  # profiles个人信息表
  # topics (user_id, tag_id, title, content)日志表
  # comments 针对这些资源回应(post/events/image/Dt)
  # micro 动态表
  # TODO 每天看世界最好的照片/影展
  # 组图上传,上传一次为一个作品 图片不直接隶属于活动 图片不可以评论 单个作品 和组图作品才可以评论
  # tags 图片标签表
  # logs统计
  # 其他
end
