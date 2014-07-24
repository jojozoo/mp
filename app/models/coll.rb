# == Schema Information
#
# Table name: colls
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  desc       :string(255)
#  state      :integer          default(1)
#  publish    :boolean          default(FALSE)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Coll < ActiveRecord::Base
  attr_accessible :user_id, :title, :desc, :state, :publish, :del

  STATE = {
  	1 => '每日精选',
  	2 => '每周精选',
  	3 => '每季精选',
  	4 => '用户集合'
  }
end
