class Comment < ActiveRecord::Base
  attr_accessible :content, :del, :title, :user_id, :reply_id, :obj_id, :obj_type

  belongs_to :obj, polymorphic: true, counter_cache: true
  belongs_to :user
  belongs_to :reply, class_name: 'User', foreign_key: :reply_id

  validates_presence_of     :content, 
                            :message => '不能为空'

  validates_length_of       :content,
                            :within => 5..200,
                            :message => '长度5..200字'
end
