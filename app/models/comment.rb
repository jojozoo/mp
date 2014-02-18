class Comment < ActiveRecord::Base
  belongs_to :obj
  attr_accessible :content, :del, :title, :user_id
end
