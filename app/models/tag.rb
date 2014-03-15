# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  channel    :string(255)
#  objs_count :integer          default(0)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :objs_count, :name, :channel, :del

  CHANNEL = ['常用', '器材', '题材', '风格技巧']
  
  validates_presence_of     :name, 
                            :message => '不能为空'
end
