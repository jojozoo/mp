class Notice < ActiveRecord::Base
  attr_accessible :content, :read, :sends_id, :title, :user_id
end
