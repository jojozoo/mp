# == Schema Information
#
# Table name: images
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  user_id              :integer
#  event_id             :integer
#  work_id              :integer
#  album_id             :integer
#  state                :boolean          default(FALSE)
#  likes_count          :integer          default(0)
#  stores_count         :integer          default(0)
#  recoms_count         :integer          default(0)
#  comments_count       :integer          default(0)
#  warrant              :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  hex                  :string(255)
#  randomhex            :string(255)
#  desc                 :string(255)
#  exif                 :text
#  wh                   :string(255)
#  del                  :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

# require 'paperclip_processors/watermark'
class Image < ActiveRecord::Base
  include TuiCore
  # store :exif
  attr_accessible :user_id, :event_id, :work_id, :album_id, :warrant, :state, :exif, :wh, :name, :desc, :randomhex, :hex, :picture, :del, :likes_count, :recoms_count, :stores_count, :comments_count
  # state 状态 (上传完成: 作品/相册上传过程中跳转了,回来应该接着显示,如果不完成,那么就不显示到活动页或者相册页) 
  # state 改变注定album_id 或event_id有值
  # TODO state 上传过程中存在相册id或者活动id就应该为state true
  # 几种水印图, 原图无水印,原图水印,大图水印, 中图水印, 小图中间水印, 头像, 50x50无水印
  # cover 封面
  # 如果是图片后缀, 但不是图片, 那么图片会加载不起来, 要想办法统计到, 现在的方式是通过日志分析

  # 必须要在 public/images/water/目录存在相对应key的水印图
  Water = {
    big: "960x600>",
    thumb: '250>',
    cover: '250x160#',
    small: '100x100>'
  }
  # TODO 更新picture时自动获取exif信息 参考 paperclip.rb 文件
  # avatar 时自动获取宽高 参考 paperclip.rb 文件
  has_attached_file :picture,
    processors: [:watermark],
    styles: Hash[Water.map{|k,v| [k, {geometry: v, water_path: "#{Rails.root.to_s}/public/images/water/#{k}.png", quality: :better}]}],
    url: "/system/:class/:id/:updated_at/:id_partition/:style/:random.:extension",
    path: ":rails_root/public/system/:class/:id/:style/:randomp.:extension"

  belongs_to :user
  belongs_to :event
  belongs_to :work
  belongs_to :album
  has_many   :pushes, as: :obj, order: 'updated_at desc'
  has_many   :comments, as: :obj, order: 'id desc'

  after_picture_post_process :load_exif
  before_picture_post_process :gen_hex
  after_save :random_hex
  def gen_hex
    self.hex = SecureRandom.hex(6)
  end

  def random_hex
    self.randomhex = (('a'..'z').to_a + ('A'..'Z').to_a).sample(30).join('')
  end

  def load_exif
    original_filename = picture.original_filename
    attachment        = picture.queued_for_write[:original].path # picture.path
    self.exif = begin
        hash = case original_filename
        when /\.(jpg|jpeg)$/i
            EXIFR::JPEG.new(attachment).to_hash
        when /\.(tif|tiff)$/i
            tiff = EXIFR::TIFF.new(attachment)
            tiff.to_hash.merge(:width => tiff.width, :height => tiff.height)
        else
            {}
        end

        hash.each {|k,v| hash[k] = case v when Rational then v.to_f when EXIFR::TIFF::Orientation then v.to_i else v end }
        hash
    rescue
        {}
    end.to_json
    self.wh = Paperclip::Geometry.from_file(picture.queued_for_write[:thumb].path).to_s rescue '250x160'
  end

  def prev(offset = 0)
    # self.class.first(:conditions => ['work_id = ? and id < ?', self.work_id, self.id], :limit => 1, :offset => offset, :order => "id DESC") || self
    self.class.first(:conditions => ['id < ?', self.id], :limit => 1, :offset => offset, :order => "id DESC") || self
  end

  def next(offset = 0)
    self.class.first(:conditions => ['id > ?', self.id], :limit => 1, :offset => offset, :order => "id ASC") || self
  end

    # before_post_process
    # after_post_process
    # before_<attachment>_post_process
    # after_<attachment>_post_process
    # 官方说尽可能和activerecord的filter一样,但是返回false(特别是nil), 是不一样的,这个post process将停止

    # imageimgick

    # 1 生成文字图片
    # convert 
    # -resize 200x200       控制图片大小
    # -background '#269abc' 背景颜色
    # -fill '#fff'          字体颜色
    # -font 'font-path'     控制字体
    # -pointsize 48         字体大小
    # -stroke ''            字体边框颜色
    # -strokewidth 1        字体边框宽度
    # -gravity center       控制位置
    # -rotate 1             旋转角度
    # label:'朱'            文字
    # wenzi.jpg             要生成的图片
    # convert -resize 200x200 -background '#269abc'-fill '#fff'-font 'font-path'-pointsize 48-stroke ''-strokewidth 1-gravity center-rotate 1 label:'朱' out.jpg

    # 2 添加图片水印
    # composite
    # -dissolve 60    控制透明度
    # -gravity south  控制方向
    # -geometry +0+60 控制详细坐标
    # wenzi.jpg       生成的图片
    # waterbg.jpg     背景图
    # water.jpg       水印图
    # composite -dissolve 60 -gravity south -geometry +0+60 wenzi.jpg waterbg.jpg water.jpg
    
end
