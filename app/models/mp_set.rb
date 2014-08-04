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
	# 1 => '每日精选',
	# 2 => '每周精选',
	# 3 => '文章推荐',
	# 4 => '活动推荐',
	1 => '首页四格一',
	2 => '首页四格二',
	3 => '首页四格三',
	4 => '首页四格四',
	7 => '首页四格五',
	5 => '重点文章',
	6 => '活动公告',
  }
end
