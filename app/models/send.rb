class Send < ActiveRecord::Base
  attr_accessible :content, :del, :tag, :title
  # 全站通知表
  # tag 什么类型的通知
  # 通知表可以不存在, 在后台管理时有通知tab
  # 之后有导航:全站,全部用户,圈子,活动,用户
  def after_create(target)
    # target = 什么类型
  end
end
