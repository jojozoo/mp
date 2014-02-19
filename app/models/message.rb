class Message < ActiveRecord::Base
  attr_accessible :content, :talk_id, :user_id, :del

  validates_presence_of   :content, message: '不能为空'
  validates_length_of     :content, 
                          :within => 5..200,
                          :message => '长度5..200字'

  belongs_to :talk, counter_cache: true
  belongs_to :user

end
