class Message < ActiveRecord::Base
  attr_accessible :text, :talk_id, :user_id, :del

  belongs_to :talk, counter_cache: true
  belongs_to :user

end
