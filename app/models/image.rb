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
#  groupid              :integer
#  state                :boolean          default(FALSE)
#  visits_count         :integer          default(0)
#  likes_count          :integer          default(0)
#  stores_count         :integer          default(0)
#  recoms_count         :integer          default(0)
#  comments_count       :integer          default(0)
#  pushes_count         :integer          default(0)
#  choice               :boolean          default(FALSE)
#  choiced_at           :datetime
#  pushed_at            :datetime
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

#  pushes_count         :integer          default(0)
#  pushed_at            :datetime
#  choice               :tinyint(1)       default(0)
#  choiced_at           :datetime

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
  attr_accessible :user_id, 
  :event_id, 
  :work_id, 
  :album_id, 
  :warrant, 
  :state, 
  :visits_count, 
  :exif, 
  :wh, 
  :name, 
  :desc, 
  :groupid, 
  :hex, 
  :randomhex, 
  :picture, 
  :del, 
  :likes_count, 
  :recoms_count, 
  :stores_count, 
  :comments_count,
  :pushes_count,
  :pushed_at,
  :choice,
  :choiced_at
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

  has_attached_file :picture,
    processors: [:watermark],
    styles: Hash[Water.map{|k,v| [k, {geometry: v, water_path: "#{Rails.root.to_s}/public/images/water/#{k}.png", quality: :better}]}],
    url: "/system/:class/:id/:style/:randomp.:extension",
    path: ":rails_root/public/system/:class/:id/:style/:randomp.:extension"

  belongs_to :user
  belongs_to :event
  belongs_to :work
  belongs_to :album
  has_many   :pushes, as: :obj, order: 'updated_at desc'
  has_many   :visits, as: :obj
  has_many   :comments, as: :obj, order: 'id desc'

  after_picture_post_process :load_exif
  before_picture_post_process :gen_hex
  after_create :random_hex
  def gen_hex
    self.hex = SecureRandom.hex(6)
  end

  def random_hex
    self.randomhex = (('a'..'z').to_a + ('A'..'Z').to_a).sample(10).join('')
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
    EXIFDATA = {
      'width'                     => '宽',
      'height'                    => '高',
      'make'                      => '制造厂商',
      'model'                     => '相机型号',
      'orientation'               => '影像方向',
      'x_resolution'              => '影像分辨率 X',
      'y_resolution'              => '影像分辨率 Y',
      'resolution_unit'           => '分辨率单位',
      'software'                  => '软件版本',
      'date_time'                 => '最后异动时间',
      'ycb_cr_positioning'        => '色相定位',
      'exposure_time'             => '曝光时间',
      'f_number'                  => '光圈系数',
      'exposure_program'          => '曝光程序',
      'iso_speed_ratings'         => 'ISO感光度',
      'date_time_original'        => '影像拍摄时间',
      'date_time_digitized'       => '影像存入时间',
      'shutter_speed_value'       => '快门速度',
      'aperture_value'            => '光圈值',
      'brightness_value'          => '亮度值',
      'metering_mode'             => '测光模式',
      'flash'                     => '闪光灯',
      'focal_length'              => '焦距',
      'color_space'               => '色彩空间',
      'pixel_x_dimension'         => '影像尺寸 X',
      'pixel_y_dimension'         => '影像尺寸 Y',
      'sensing_method'            => '检测方法',
      'exposure_mode'             => '曝光模式',
      'white_balance'             => '白平衡',
      'focal_length_in_35mm_film' => '等价35mm焦距',
      'scene_capture_type'        => '情景拍摄类型',
      'gps_latitude_ref'          => 'GPS纬度参考',
      'gps_latitude'              => 'GPS纬度参考',
      'gps_longitude_ref'         => 'GPS经度参考',
      'gps_longitude'             => 'GPS经度参考',
      'gps_altitude_ref'          => 'GPS高度参考',
      'gps_altitude'              => 'GPS高度参考',
      # 'gps_time_stamp'          => 'gps_time_stamp',
      'gps_img_direction_ref'     => 'GPS图像方向参考',
      'gps_img_direction'         => 'GPS图像方向'
    }
    EXIFLETH = ['make', 'model', 'date_time', 'exposure_time', 'gps_latitude', 'gps_longitude']

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

          if hash[:gps_latitude].present? and hash[:gps_longitude].present?
            lat = hash[:gps_latitude]
            log = hash[:gps_longitude]
            latv = lat[0].to_f + (lat[1].to_f / 60) + (lat[2].to_f / 3600)
            latv = lat * -1 if hash[:gps_latitude_ref] == 'S'
            logv = log[0].to_f + (log[1].to_f / 60) + (log[2].to_f / 3600)
            logv = logv * -1 if hash[:gps_longitude_ref] == 'W'
            hash[:gps_latitude]  = latv
            hash[:gps_longitude] = logv
          end

          hash.each {|k,v| hash[k] = case v when Rational then v.to_f when EXIFR::TIFF::Orientation then v.to_i else v.to_s end }
          hash
      rescue
          {}
      end.to_json
      self.wh = Paperclip::Geometry.from_file(picture.queued_for_write[:thumb].path).to_s rescue '250x160'
    end

end
