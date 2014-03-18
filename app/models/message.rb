# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  sender_id  :integer
#  user_id    :integer
#  state      :integer          default(0)
#  u_is_del   :boolean          default(FALSE)
#  s_is_del   :boolean          default(FALSE)
#  content    :string(255)
#  del        :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :sender_id, :user_id, :state, :s_is_del, :u_is_del,  :content, :del

  validates_presence_of   :content, message: '不能为空'
  validates_length_of     :content, 
                          :within => 1..200,
                          :message => '长度1..200字'

  belongs_to :sender, class_name: 'User', counter_cache: :messages_count
  belongs_to :user
  has_many :inners, class_name: 'Message'

  def unread?
    state.zero?
  end

  def read?
    state == 1
  end

  def trash?
    state == 2
  end

  STATE = {
    0 => '未读',
    1 => '已读',
    2 => '垃圾'
  }

end
