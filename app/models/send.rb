class Send < ActiveRecord::Base
  attr_accessible :title, :content, :tag, :target, :del
  # 全站通知表
  # tag 什么类型的通知
  # 通知表可以不存在, 在后台管理时有通知tab
  # 之后有导航:全站,全部用户,圈子,活动,用户
  def after_create(target)
    # target = 什么类型
  end
  validates_presence_of :title, :content, :tag, :target,
                        message: '不能为空'

  TAG    = ['邮件','漫信','页面']
  TARGET = ['全站', '全部用户', '图库', '活动', '动态', '圈子']

  scope :site, -> {where(tag: '页面')}
end
