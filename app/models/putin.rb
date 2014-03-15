# == Schema Information
#
# Table name: putins
#
#  id         :integer          not null, primary key
#  ad_id      :integer
#  click      :integer          default(0)
#  browser    :integer          default(0)
#  from       :string(255)      default("mp")
#  start_time :datetime
#  end_time   :datetime
#  state      :boolean          default(FALSE)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Putin < ActiveRecord::Base
  attr_accessible :ad_id, :browser, :click, :from, :start_time, :end_time, :state, :del
  # browser 浏览数
  # click   点击数
  # from    来源

  belongs_to :ad
end
