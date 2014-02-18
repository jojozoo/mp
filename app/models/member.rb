class Member < ActiveRecord::Base
  attr_accessible :auth, :del, :group_id, :user_id
end
