class Push < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :type, :user_id, :mark
  
  belongs_to :obj, polymorphic: true

  validates_uniqueness_of :user_id, 
                          :scope => [:obj_type, :obj_id, :type],
                          :message => '重复操作'
end
