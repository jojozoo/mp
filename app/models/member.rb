class Member < ActiveRecord::Base
  attr_accessible :event_id, :sum, :user_id, :del
  belongs_to :user
  belongs_to :event
end
