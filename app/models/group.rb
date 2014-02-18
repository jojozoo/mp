class Group < ActiveRecord::Base
  attr_accessible :desc, :members_count, :publish, :title, :topics_count, :user_id, :visits_count
end
