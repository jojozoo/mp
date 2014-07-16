class Coll < ActiveRecord::Base
  attr_accessible :user_id, :title, :desc, :state, :publish, :del

  STATE = {
  	1 => '每日精选',
  	2 => '每周精选',
  	3 => '每季精选',
  	4 => '用户集合'
  }
end
