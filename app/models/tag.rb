class Tag < ActiveRecord::Base
  attr_accessible :objs_count, :name, :channel, :del

  CHANNEL = ['常用', '器材', '题材', '风格技巧']
  
  validates_presence_of     :name, 
                            :message => '不能为空'
end
