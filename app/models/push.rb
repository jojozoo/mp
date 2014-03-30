# == Schema Information
#
# Table name: pushes
#
#  id          :integer          not null, primary key
#  obj_id      :integer
#  obj_type    :string(255)
#  source_id   :integer
#  source_type :string(255)
#  channel     :string(255)
#  user_id     :integer
#  mark        :string(255)
#  del         :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Push < ActiveRecord::Base
  # 只为管理员使用
  attr_accessible :obj_id, :obj_type, :source_id, :source_type, :channel, :user_id, :mark, :del
  
  belongs_to :obj, polymorphic: true
  belongs_to :source, polymorphic: true

end
