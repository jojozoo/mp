# == Schema Information
#
# Table name: photos
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  event_id             :integer
#  work_id              :integer
#  album_id             :integer
#  groupid              :integer
#  state                :boolean          default(FALSE)
#  editor               :boolean          default(FALSE)
#  score                :integer          default(0)
#  recs_count           :integer          default(0)
#  liks_count           :integer          default(0)
#  stos_count           :integer          default(0)
#  visit_count          :integer          default(0)
#  coms_count           :integer          default(0)
#  recommend            :boolean          default(FALSE)
#  recommend_at         :datetime
#  choice               :boolean          default(FALSE)
#  choice_at            :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  name                 :string(255)
#  title                :string(255)
#  desc                 :string(255)
#  warrant              :integer
#  randomhex            :string(255)
#  randomstr            :string(255)
#  exif                 :text
#  wh                   :string(255)
#  del                  :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

# require 'paperclip_processors/watermark'
class Photo < ActiveRecord::Base
  include TuiCore
  # store :exif
  attr_accessible :user_id, 
  :event_id, 
  :work_id, 
  :album_id, 
  :groupid, 
  :state, 
  :editor, 
  :score, 
  :recs_count, 
  :liks_count, 
  :stos_count, 
  :visit_count, 
  :coms_count, 
  :recommend, 
  :recommend_at, 
  :choice, 
  :choice_at, 
  :picture, 
  :name, 
  :title, 
  :desc, 
  :warrant,
  :randomhex,
  :randomstr,
  :exif,
  :wh,
  :del
  # state 状态 (上传完成: 作品/相册上传过程中跳转了,回来应该接着显示,如果不完成,那么就不显示到活动页或者相册页) 
  # state 改变注定album_id 或event_id有值
  # TODO state 上传过程中存在相册id或者活动id就应该为state true
  # 几种水印图, 原图无水印,原图水印,大图水印, 中图水印, 小图中间水印, 头像, 50x50无水印
  # cover 封面
  # 如果是图片后缀, 但不是图片, 那么图片会加载不起来, 要想办法统计到, 现在的方式是通过日志分析

  # 如果是每日精品，在左上角红色显示，如果是编辑推荐在右上角显示。分享为微博 Qzone 人人 豆瓣
  # 左下角和右下角暂时标题和用户名
  # 管理员需要的操作就显示分享的下面

  # 必须要在 public/images/water/目录存在相对应key的水印图
  Water = {
    large: "1140x>", # 根据bootstrap最宽
    thumb: '280>',
    cover: '280x280#'
  }

  has_attached_file :picture,
    styles: Hash[Water.map{|k,v| [k, {geometry: v, quality: :better}]}],
    url: "/system/:class/:id/:style/:randomp.:extension",
    path: ":rails_root/public/system/:class/:id/:style/:randomp.:extension"
  # has_attached_file :picture,
  #   processors: [:watermark],
  #   styles: Hash[Water.map{|k,v| [k, {geometry: v, water_path: "#{Rails.root.to_s}/public/images/water/#{k}.png", quality: :better}]}],
  #   url: "/system/:class/:id/:style/:randomp.:extension",
  #   path: ":rails_root/public/system/:class/:id/:style/:randomp.:extension"

  belongs_to :user
  belongs_to :event
  belongs_to :work
  belongs_to :album
  has_many   :visits, as: :obj
  has_many   :comments, as: :obj, order: 'id desc'
  has_many   :likes, class_name: 'Tui', conditions: {channel: 'like'}, as: :obj
  has_many   :stores, class_name: 'Tui', conditions: {channel: 'store'}, as: :obj
  has_many   :recoms, class_name: 'Tui', conditions: {channel: 'recom'}, as: :obj
  has_many   :tuis, as: :obj, conditions: {editor: true}

  # 有效的 state 为true的
  scope :effective, -> { where(state: true) }
  scope :choice,    -> { where(choice: true)}

  # ['like', 'store', 'recom'].each do |item|
  #   define_method "#{item}?(obj)" do
  #     "#{item}s".to_sym.exists?(user_id: obj.id)
  #   end
  # end
  before_create :gen_randomstr
  def gen_randomstr
    self.randomhex = (('a'..'z').to_a + ('A'..'Z').to_a).sample(10).join('')
    self.randomstr = SecureRandom.hex(6)
  end

  def like?(obj)
    likes.exists?(user_id: obj.id)
  end

  def store?(obj)
    stores.exists?(user_id: obj.id)
  end

  def recom?(obj)
    recoms.exists?(user_id: obj.id)
  end

  def prev(offset = 0)
    # self.class.first(:conditions => ['work_id = ? and id < ?', self.work_id, self.id], :limit => 1, :offset => offset, :order => "id DESC") || self
    self.class.first(:conditions => ['user_id = ? and id < ?', self.user_id, self.id], :limit => 1, :offset => offset, :order => "id DESC")
  end

  def next(offset = 0)
    self.class.first(:conditions => ['user_id = ? and id > ?', self.user_id, self.id], :limit => 1, :offset => offset, :order => "id ASC")
  end
  
end
