# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  channel    :string(255)
#  sum        :integer          default(0)
#  desc       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  attr_accessible :name, :channel, :sum, :desc, :del
  # TODO 添加is_hot是否常用标签 pinyin
  # channel应该=图片,活动,文章
  # cate应该是类别 ['常用', '器材', '题材', '风格技巧', '活动']
  CHANNEL = ['常用', '器材', '题材', '风格技巧', '活动']
  
  validates_presence_of     :name, 
                            :message => '不能为空'
end
