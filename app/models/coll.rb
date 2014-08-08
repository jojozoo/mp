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

  # 分系统和用户 再分类别 骑行 旅游 默认 农村 生活 漫拍(日)编辑推荐 漫拍周推荐 漫拍季推荐 漫拍年推荐
  # 其中 系统和用户暂时不用分， 只是类别可以随意添加即可
  STATE = {
  	1 => '用户集合',
  	2 => '编辑推荐',
  	3 => '每周推荐',
  	4 => '每季推荐'
  }
end
