# == Schema Information
#
# Table name: photos
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  event_id             :integer
#  work_id              :integer
#  album_id             :integer
#  isgroup              :boolean          default(FALSE)
#  parent_id            :integer
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
#  tags                 :string(255)
#  crop                 :string(255)
#  tpid                 :integer
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
  :isgroup,
  :parent_id, 
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
  :tags,
  :crop,
  :tpid,
  :wh,
  :del
  
  # 几种水印图, 原图无水印,原图水印,大图水印, 中图水印, 小图中间水印, 头像, 50x50无水印
  # cover 封面
  # 如果是图片后缀, 但不是图片, 那么图片会加载不起来, 要想办法统计到, 现在的方式是通过日志分析

  # 如果是每日精品，在左上角红色显示，如果是编辑推荐在右上角显示。分享为微博 Qzone 人人 豆瓣
  # 左下角和右下角暂时标题和用户名
  # 管理员需要的操作就显示分享的下面
  # state 精华 推荐 普通

  # 必须要在 public/images/water/目录存在相对应key的水印图
  Water = {
    large: "1140x>", # 根据bootstrap最宽
    thumb: '280>',
    cover: '280x280#',
    small: '100x100#'
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

  scope :choice,    -> { where(choice: true)}

  EXIF = {
  "camera"        => "型号",
  "lens"          => "镜头",
  "focal_length"  => "焦距",
  "shutter_speed" => "快门速度",
  "aperture"      => "光圈",
  "iso"           => "ISO",
  "taken_at"      => "拍摄时间"
  }

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
    self.class.first(:conditions => ['user_id = ? and id < ?', self.user_id, self.id], :limit => 1, :offset => offset, :order => "id DESC")
  end

  def next(offset = 0)
    self.class.first(:conditions => ['user_id = ? and id > ?', self.user_id, self.id], :limit => 1, :offset => offset, :order => "id ASC")
  end

  def self.create_items items, uid, parent = nil
    tpid = nil
    pattr = {user_id: uid, state: true}.merge(parent ? {isgroup: true, parent_id: parent.id} : {})
    items.each do |item|
      photo = Photo.create(item.merge(pattr))
      move_picture(photo)
      # 为更新parent的图
      tpid = photo.tpid

      if event = Event.find_by_id(item['event_id'])
        image_count = Photo.where(event_id: event.id).count
        membe_count = Photo.uniq.where(event_id: event.id).pluck(:user_id).length
        event.update_attributes(photos_count: image_count, members_count: membe_count)
      end
    end
    # TODO
    if parent
      last = items.last
      parent.update_attributes({event_id: last['event_id'], state: true, warrant: last['warrant']})
      move_picture(parent, tpid)
    end
  end

  def self.move_picture photo, tpid = nil
    tp = Tp.find(tpid || photo.tpid)
    ['file_name', 'content_type', 'file_size', 'updated_at'].each do |atr|
      photo.update_attribute("picture_#{atr}", tp.try("picture_#{atr}".to_sym))
    end
    extname = File.extname(tp.picture_file_name)
    orstr = Digest::MD5.hexdigest("#{photo.id}#{photo.randomstr}server")
    otstr = Digest::MD5.hexdigest("#{photo.randomstr}#{photo.id}")
    spath = "public/system/photos/#{photo.id}"
    system("mkdir #{spath}")
    system("mkdir #{spath}/original")
    system("mkdir #{spath}/large")
    system("mkdir #{spath}/thumb")
    system("mkdir #{spath}/cover")
    system("mkdir #{spath}/small")
    system("cp #{tp.picture.path(:original)} #{spath}/original/#{orstr}#{extname}")
    system("cp #{tp.picture.path(:plarge)} #{spath}/large/#{otstr}#{extname}")
    system("cp #{tp.picture.path(:pthumb)} #{spath}/thumb/#{otstr}#{extname}")
    system("cp #{tp.picture.path(:pcover)} #{spath}/cover/#{otstr}#{extname}")
    system("cp #{tp.picture.path(:psmall)} #{spath}/small/#{otstr}#{extname}")
  end
  
end
