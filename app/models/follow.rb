# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  follower_id :integer
#  mark        :string(255)
#  del         :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Follow < ActiveRecord::Base
  attr_accessible :del, :follower_id, :mark, :user_id
  # follower_id 关注者
  belongs_to :user, counter_cache: :followers_count, foreign_key: :user_id
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id

  validates_uniqueness_of :user_id, 
                          :scope => :follower_id,
                          :message => '已关注'
end
