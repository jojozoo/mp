class Comment < ActiveRecord::Base
  attr_accessible :content, :del, :title, :user_id, :obj_id, :obj_type

  belongs_to :obj, polymorphic: true
end
