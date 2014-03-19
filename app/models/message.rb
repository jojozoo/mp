# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  sender_id  :integer
#  user_id    :integer
#  talk       :string(255)
#  state      :integer          default(0)
#  s_is_del   :integer          default(0)
#  u_is_del   :integer          default(0)
#  content    :string(255)
#  del        :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  attr_accessible :sender_id, :user_id, :talk, :state, :s_is_del, :u_is_del, :content, :del

  validates_presence_of   :content, message: '不能为空'
  validates_length_of     :content, 
                          :within => 1..200,
                          :message => '长度1..200字'

  belongs_to :sender, class_name: 'User'
  belongs_to :user, counter_cache: :messages_count
  has_many :inners, class_name: 'Message', primary_key: :talk, foreign_key: :talk


  STATE = {
    0 => '未读',
    1 => '已读',
    2 => '垃圾'
  }

end
