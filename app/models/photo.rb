# == Schema Information
#
# Table name: photos
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  event_id             :integer
#  work_id              :integer
#  gl_id                :integer
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
#  crop                 :text
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
  :gl_id,
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

  # 如果是每日精品，在左上角红色显示，如果是推荐精选在右上角显示。分享为微博 Qzone 人人 豆瓣
  # 左下角和右下角暂时标题和用户名
  # 管理员需要的操作就显示分享的下面
  # state 精华 推荐 普通
  store :exif
  store :crop
  # 必须要在 public/images/water/目录存在相对应key的水印图
  Water = {
    large: "1140x>", # 根据bootstrap最宽
    thumb: '280>',
    cover: '280x280#',
    small: '100x100#'
  }

  has_attached_file :picture,
    styles: Hash[Water.map{|k,v| [k, {geometry: v, quality: :better}]}],
    url: "http://#{Rails.env.eql?('development') ? 'localhost:3000' : 'mpwang.cn'}/system/:class/:id/:style/:randomp.:extension",
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
  has_many   :liks, class_name: 'Tui', conditions: {channel: 'liks'}, as: :obj
  has_many   :stos, class_name: 'Tui', conditions: {channel: 'stos'}, as: :obj
  has_many   :recs, class_name: 'Tui', conditions: {channel: 'recs'}, as: :obj
  has_many   :childrens, class_name: 'Photo', foreign_key: :parent_id
  # has_many   :tuis, as: :obj, conditions: {editor: true}

  scope :choice,    -> { where(choice: true).order('choice_at')}

  EXIF = {
  "camera"        => "型号",
  "lens"          => "镜头",
  "focal_length"  => "焦距",
  "shutter_speed" => "快门速度",
  "aperture"      => "光圈",
  "iso"           => "ISO",
  "taken_at"      => "拍摄时间"
  }
  ORDER = {
      'news'  => ['id desc', 'upload', '最新上传'],
      'choi'  => ['choice_at desc','choi', '精选图片'],
      'liks'  => ['liks_count desc','heart', '喜欢最多'],
      'coms'  => ['coms_count desc','comments', '评论最多'],
      'recs'  => ['recommend_at desc','ok-circle', '编辑推荐'],
      'choi'  => ['choice_at desc','time', '精选作品'],
      'radm'  => ['randomhex desc','random', '随机浏览'],
      'vist'  => ['visit_count desc', '', '人气最高'],
      'myse'  => ['visit_count desc','', '我的漫拍']
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

  def liks?(obj)
    liks.exists?(editor_id: obj.id)
  end

  def stos?(obj)
    stos.exists?(editor_id: obj.id)
  end

  def recs?(obj)
    recs.exists?(editor_id: obj.id)
  end

  def prev
    self.class.first(:conditions => ['user_id = ? and id > ? and parent_id is null', self.user_id, self.id], :limit => 1, order: 'id asc')
  end

  def next
    self.class.first(:conditions => ['user_id = ? and id < ? and parent_id is null', self.user_id, self.id], :limit => 1, order: 'id desc')
  end

  def self.create_items items, uid, parent = nil
    tpid = nil
    pattr = {user_id: uid, state: true}.merge(parent ? {isgroup: true, parent_id: parent.id} : {})
    lastitem = nil
    items.each do |item|
      photo = Photo.create(item.merge(pattr))
      lastitem = photo
      move_picture(photo)
      # 为更新parent的图
      tpid = photo.tpid

      if event = Event.find_by_id(item['event_id'])
        image_count = Photo.where(["event_id = ? and (isgroup = ? and parent_id is not null or isgroup = ? and parent_id is null)", event.id, true, false]).count
        membe_count = Photo.uniq.where(event_id: event.id).pluck(:user_id).length
        event.update_attributes(photos_count: image_count, members_count: membe_count)
        if item['album_id'].blank?
          album = Album.find_or_create_by_user_id_and_name(uid, event.name)
          photo.update_attributes(album_id: album.id)
        end
      else
        default_album = Album.find_or_create_by_user_id_and_name(uid, '默认相册')
        default_album = if item['album_id'].blank?
          Album.find_by_user_id_and_id(uid, item['album_id']) || default_album
        else
          default_album
        end
        photo.update_attributes(album_id: default_album.id)
      end
    end
    # TODO
    if parent
      last = lastitem
      parent.update_attributes({event_id: last.event_id, state: true, warrant: last.warrant, gl_id: last.id})
    end
    parent || lastitem
  end

  def self.move_picture photo
    tp = Tp.find(photo.tpid)
    # 改为一条更新
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
