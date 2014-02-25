class Tui < ActiveRecord::Base
  attr_accessible :del, :obj_id, :obj_type, :mark, :type, :score, :user_id
  
  # belongs_to :obj, polymorphic: true, counter_cache: true
  belongs_to :user

  validates_uniqueness_of :user_id, 
                          :scope => [:obj_type, :obj_id, :type],
                          :message => '重复操作'

  # ['tuis', 'lauds', 'likes', 'stores', 'recoms']
end