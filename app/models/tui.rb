class Tui < ActiveRecord::Base
  attr_accessible :del, :obj_id, :obj_type, :mark, :type, :score, :user_id
  
  belongs_to :obj, polymorphic: true

  validates_uniqueness_of :user_id, 
                          :scope => [:obj_type, :obj_id],
                          :message => '相册已存在'
end
