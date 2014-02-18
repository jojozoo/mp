class Push < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :type, :user_id, :mark
  belongs_to :obj, polymorphic: true
end
