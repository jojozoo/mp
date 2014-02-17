class Putin < ActiveRecord::Base
  attr_accessible :ad_id, :browser, :click, :from, :start_time, :end_time, :state, :del
  # browser 浏览数
  # click   点击数
  # from    来源

  belongs_to :ad
end
