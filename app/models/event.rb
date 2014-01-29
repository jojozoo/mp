class Event < ActiveRecord::Base
  attr_accessible :text,
   :logo, 
   :tag, 
   :end_time, 
   :works_count, 
   :members_count, 
   :show, 
   :state, 
   :title, 
   :user_id, 
   :del
  # user_id 发起人
  # works_count: 图片数量
  # members_count 参与者数量
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
  has_attached_file :logo,
    styles: {
      thumb: '200x200',
      small: '200x120'
    }


  # 作品 参与活动的作品
  has_many :works
  # 参与活动的照片
  has_many :images, through: :work, source: :image
  # 发起活动的人
  has_one :publisher, class_name: 'User', foreign_key: :user_id
  # 参与活动的人
  has_many :members, through: :work, source: :user
  # 活动获奖的人 大于0 asc排序: 0参与 1等奖 2等奖
  has_many :winners, :class_name => 'User', :conditions => '`works`.`winner` > 0'

  
end

