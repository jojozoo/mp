# == Schema Information
#
# Table name: tuis
#
#  id          :integer          not null, primary key
#  obj_id      :integer
#  obj_type    :string(255)
#  source_id   :integer
#  source_type :string(255)
#  channel     :string(255)
#  user_id     :integer
#  editor      :integer
#  editor_id   :integer
#  mark        :string(255)
#  del         :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tui < ActiveRecord::Base
  attr_accessible :obj_id, 
  :obj_type, 
  :source_id, 
  :source_type, 
  :channel,
  :user_id,
  :editor,
  :editor_id,
  :mark, 
  :del

  # TODO 管理员推荐存在重复性 即一个管理员一次推荐会记录一次，哪怕是重复资源
  
  # owner_id 介绍 如果在tui表有相关文章只会显示在首页的推荐重点.如果owner_id关联为活动ID，那么此文章会显示在活动右侧的相关栏目
  # 推荐数 喜欢数之类的
  belongs_to :obj, polymorphic: true#, counter_cache: true
  belongs_to :user

  validates_uniqueness_of :user_id, 
                          :scope => [:obj_type, :obj_id],
                          :message => '重复操作'

  TIP = {
    followd: '被关注',
    recom:   '被推荐',
    like:    '被喜欢',
    store:   '被收藏',
    comment: '被回应',
    msg:     '收到漫信'
  }
  
  RECOMMENDEDTYPE = {
    'like'          => '喜欢',
    'store'         => '收藏',
    'recommend'     => '编辑推荐',
    'selfrecommend' => '自荐',
    'choice'        => '精选',
    'star'          => '慢拍之星',
    'photographer'  => '推荐摄影师',
    'emphasis'      => '推荐重点',
    'request'       => '推荐活动'
  }
  RECOMMENDEDTYPE.each do |key, value|
    # 对应的obj_type和id找到对应的资源
    # (obj_type.downcase + '_path').to_sym(obj_id)
    scope key, -> {where(channel: key)}
  end
  

end
