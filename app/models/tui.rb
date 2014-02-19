class Tui < ActiveRecord::Base
  attr_accessible :del, :obj_id, :obj_type, :mark, :type, :score, :user_id
  
  belongs_to :obj, polymorphic: true

end
