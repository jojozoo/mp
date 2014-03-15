# == Schema Information
#
# Table name: talks
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  sender_id      :integer
#  content        :string(255)
#  state          :integer          default(1)
#  messages_count :integer          default(0)
#  del            :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Talk < ActiveRecord::Base
  attr_accessible :del, :state, :content, :user_id, :sender_id, :messages_count

  belongs_to :user
  belongs_to :sender, class_name: 'User'
  has_many :messages, order: 'id desc'
  # state(1未读/0已读/2垃圾) 暂时没有垃圾之说吧

  def read?
    state.zero?
  end

  def unread?
    state == 1
  end

  def trash?
    state != 1 and state != 0
  end
  
end
