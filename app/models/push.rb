# == Schema Information
#
# Table name: pushes
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  type       :string(255)
#  user_id    :integer
#  mark       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Push < ActiveRecord::Base
  # 只为管理员使用
  attr_accessible :obj_id, :obj_type, :type, :user_id, :mark
  
  belongs_to :obj, polymorphic: true

  validates_uniqueness_of :user_id, 
                          :scope => [:obj_type, :obj_id, :type],
                          :message => '重复操作'
end
