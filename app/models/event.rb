class Event < ActiveRecord::Base
  attr_accessible :content, :tag, :end_time, :logo_id, :images_count, :partners_count, :show, :state, :title, :user_id, :del
  # user_id 发起人
  # images through:des 参与者图片
  # images_count: 图片数量
  # partners_count 参与者数量
  # state 审核中 未通过 进行中 已结束(0,1,2,3)
  # show 是否显示到全站导航
  # logo
  # tag 暂时有同城,年度,一般 
  # 导航显示方法
    # 1 推荐显示一般活动
    # 2 推荐显示同城活动
    # 3 推荐显示年度活动
    # 4 正在进行的活动
    # 5 已结束的活动
  has_one :logo, class_name: 'Image', foreign_key: :logo_id
  has_one :de, as: :source
  # 参与活动的照片
  has_many :images, through: :de, source: :image
  # 参与者
  has_many :partners
  # 获奖者 如果winner数据挪到des表,这些该如何存储
  has_many :winners, :class_name => 'Partner', :conditions => '`partners`.`winner` = 1'

  
end
