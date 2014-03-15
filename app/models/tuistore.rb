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

class Tuistore < Tui
  belongs_to :obj, polymorphic: true, counter_cache: :stores_count
end
