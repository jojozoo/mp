class Visit < ActiveRecord::Base
  attr_accessible :del, :mark, :type, :user_id, :obj_id, :obj_type
  
  belongs_to :obj
end
