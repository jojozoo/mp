# == Schema Information
#
# Table name: mp_sets
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  link       :string(255)
#  src        :string(255)
#  cate       :integer
#  cate_id    :integer
#  user_id    :integer
#  desc       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MpSet < ActiveRecord::Base
  attr_accessible :cate, :cate_id, :desc, :link, :src, :title, :user_id, :del

  Cate = {
	# 1 => '编辑推荐',
	# 2 => '每周推荐',
	# 3 => '文章推荐',
	# 4 => '活动推荐',
	1 => '一格',
	2 => '二格',
	3 => '三格',
	4 => '四格',
	7 => '五格',
	5 => '重点文章',
	8 => '摄影信息',
	6 => '活动公告',
  }
end
