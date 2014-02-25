class Follow < ActiveRecord::Base
  attr_accessible :del, :follower_id, :mark, :user_id
  # follower_id 关注者
  belongs_to :user
  belongs_to :follower, class_name: 'User'

  validates_uniqueness_of :user_id, 
                          :scope => :follower_id,
                          :message => '已关注'
end
