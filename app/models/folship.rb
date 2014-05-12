# == Schema Information
#
# Table name: folships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  fol_id     :integer
#  mark       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Folship < ActiveRecord::Base
  attr_accessible :user_id, :fol_id, :mark, :del
  # fol_id 关注者
  belongs_to :user, counter_cache: :fols_count, foreign_key: :user_id

  belongs_to :fol,  class_name: 'User', foreign_key: :fol_id

  validates_uniqueness_of :user_id, 
                          :scope => :fol_id,
                          :message => '已关注'
end
