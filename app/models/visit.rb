# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  user_id    :integer
#  mark       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Visit < ActiveRecord::Base
  attr_accessible :del, :mark, :user_id, :obj_id, :obj_type
  
  belongs_to :obj, polymorphic: true, counter_cache: true
end
