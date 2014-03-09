class ObjTag < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :tag_id, :del

  belongs_to :obj, polymorphic: true
  belongs_to :tag, counter_cache: :objs_count
end