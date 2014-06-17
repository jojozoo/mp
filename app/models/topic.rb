# == Schema Information
#
# Table name: topics
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  cate_id         :integer
#  owner_id        :integer
#  last_user_id    :integer
#  last_updated_at :datetime
#  emphasis        :boolean          default(FALSE)
#  emphasis_at     :datetime
#  original        :boolean          default(TRUE)
#  title           :string(255)
#  content         :text
#  coms_count      :integer          default(0)
#  del             :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :user_id, :cate_id, :owner_id, :last_user_id, :last_updated_at, :emphasis, :emphasis_at, :original, :title, :content, :coms_count, :del
  # owner_id 属于某个活动的文章 但是创建文章的时候应该如何关联？ 只在后台有权限关联好了，前台只可以添加活动标签
  # 
  has_many :comments, as: :obj
  has_many :tagships, as: :obj
  
  belongs_to :user
  belongs_to :owner, class_name: 'Event', foreign_key: :owner_id
  belongs_to :last_user, class_name: 'User', foreign_key: :last_user_id
  has_many :visits, as: :obj

  belongs_to :cate, class_name: 'Tag', foreign_key: :cate_id

  scope :emphasis, -> {where(emphasis: true)}


  validates_presence_of     :user_id, 
                            message: '不能为空'

  validates_presence_of     :title, 
                            message: '不能为空'

  validates_length_of       :title,
                            within: 3..20,
                            message: '长度3..20字'

  validates_presence_of     :content,
                            message: '不能为空'

  # validates_length_of       :content,
  #                           within: 10..300,
  #                           message: '长度10..300字'

  validates_presence_of     :cate_id,
                            message: '不能为空'
end
