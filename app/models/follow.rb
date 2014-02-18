class Follow < ActiveRecord::Base
  attr_accessible :del, :follower_id, :mark, :user_id
end
