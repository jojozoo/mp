class Topic < ActiveRecord::Base
  attr_accessible :content, :del, :group_id, :title, :user_id
end
