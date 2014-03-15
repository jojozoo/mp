# == Schema Information
#
# Table name: obj_tags
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  tag_id     :integer
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ObjTag < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :tag_id, :del

  belongs_to :obj, polymorphic: true
  belongs_to :tag, counter_cache: :objs_count
end
