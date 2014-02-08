class Message < ActiveRecord::Base
  attr_accessible :text, :talk_id, :user_id, :del

  validates_presence_of   :text, message: '不能为空'
  validates_length_of     :text, 
                          :within => 5..200,
                          :message => '长度5..200字'

  belongs_to :talk, counter_cache: true
  belongs_to :user

end
