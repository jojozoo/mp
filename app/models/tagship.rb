# == Schema Information
#
# Table name: tagships
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  name       :string(255)
#  channel    :string(255)
#  tag_id     :integer
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tagship < ActiveRecord::Base
  attr_accessible :obj_id, :obj_type, :name, :channel, :tag_id, :del

  belongs_to :obj, polymorphic: true
  belongs_to :tag, counter_cache: :sum
end
