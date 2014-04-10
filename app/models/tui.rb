# == Schema Information
#
# Table name: tuis
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  type       :string(255)
#  user_id    :integer
#  score      :integer          default(0)
#  mark       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tui < ActiveRecord::Base
  attr_accessible :del, :obj_id, :obj_type, :mark, :type, :score, :user_id
  
  # belongs_to :obj, polymorphic: true, counter_cache: true
  belongs_to :user

  validates_uniqueness_of :user_id, 
                          :scope => [:obj_type, :obj_id, :type],
                          :message => '重复操作'

end
