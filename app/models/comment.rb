# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  user_id    :integer
#  reply_id   :integer
#  title      :string(255)
#  content    :text
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :obj_id, 
  :obj_type, 
  :user_id, 
  :reply_id, 
  :title, 
  :content, 
  :del

  belongs_to :obj, polymorphic: true, counter_cache: true
  belongs_to :user
  belongs_to :reply, class_name: 'User', foreign_key: :reply_id

  validates_presence_of     :content, 
                            :message => '不能为空'

  validates_length_of       :content,
                            :within => 5..200,
                            :message => '长度5..200字'
end
