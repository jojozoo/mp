# == Schema Information
#
# Table name: tps
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  exif                 :text
#  randomstr            :string(255)
#  del                  :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require 'paperclip_processors/watermark'
class Tp < ActiveRecord::Base
  attr_accessible :picture, :user_id
  
  has_attached_file :picture,
    processors: [:watermark],
    styles: {
      large: { quality: :better, geometry: '1140x700>'},
      thumb: { quality: :better, geometry: '100x100>'},
      plarge: { quality: :better, geometry: '1140x700>', water_path: "#{Rails.root.to_s}/public/images/water/large.png" },
      pthumb: { quality: :better, geometry: '280x280>', water_path: "#{Rails.root.to_s}/public/images/water/thumb.png" },
      pcover: { quality: :better, geometry: '280x280#', water_path: "#{Rails.root.to_s}/public/images/water/cover.png"},
      psmall: { quality: :better, geometry: '100x100#'}
    },
    url: "/system/:class/:id/:id_partition/:style/:random.:extension",
    path: ":rails_root/public/system/:class/:id/:style/:randomp.:extension"

    after_picture_post_process :load_exif
    before_picture_post_process :gen_randomstr

    def gen_randomstr
      self.randomstr = SecureRandom.hex(6)
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
    }.symbolize_keys!
    EXIFLETH = ['model', 'les', 'focal_length', 'shutter_speed_value', 'aperture_value', 'iso_speed_ratings', 'date_time_original', 'gps_latitude', 'gps_longitude'].map(&:to_sym)
    # EXIFREVERT = {

    # }
    def load_exif
      original_filename = picture.original_filename
      attachment        = picture.queued_for_write[:original].path # picture.path
      exif = begin
          hash = case original_filename
          when /\.(jpg|jpeg)$/i
              EXIFR::JPEG.new(attachment).to_hash
          when /\.(tif|tiff)$/i
              tiff = EXIFR::TIFF.new(attachment)
              tiff.to_hash.merge(:width => tiff.width, :height => tiff.height)
          else
              {}
          end
          [:date_time_digitized, :date_time_original, :exposure_time, :date_time].each do |time|
            hash[time] = hash[time].to_time.to_s(:db) rescue nil
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
      end
      # ap exif
      # 根据字符串转换成当地时间javascript
      exif = exif.slice(*EXIFLETH)
      exifexif['date_time'] = exif['date_time_original']
      [:original, :large, :thumb].each do |item|
        w, h = Paperclip::Geometry.from_file(picture.queued_for_write[item].path).to_s.split("x") rescue ['', '']
        exif.merge!("#{item}_width".to_sym => w, "#{item}_height" => h)
      end
      self.exif = exif.to_json
    end
end
