module ImageCore
  extend ActiveSupport::Concern
  
  included do
    EXIFDATA = {
                        'width' => '宽',
                       'height' => '高',
                         'make' => '制造厂商',
                        'model' => '相机型号',
                  'orientation' => '影像方向',
                 'x_resolution' => '影像分辨率 X',
                 'y_resolution' => '影像分辨率 Y',
              'resolution_unit' => '分辨率单位',
                     'software' => '软件版本',
                    'date_time' => '最后异动时间',
           'ycb_cr_positioning' => '色相定位',
                'exposure_time' => '曝光时间',
                     'f_number' => '光圈系数',
             'exposure_program' => '曝光程序',
            'iso_speed_ratings' => 'ISO感光度',
           'date_time_original' => '影像拍摄时间',
          'date_time_digitized' => '影像存入时间',
          'shutter_speed_value' => '快门速度',
               'aperture_value' => '光圈值',
             'brightness_value' => '亮度值',
                'metering_mode' => '测光模式',
                        'flash' => '闪光灯',
                 'focal_length' => '焦距',
                  'color_space' => '色彩空间',
            'pixel_x_dimension' => '影像尺寸 X',
            'pixel_y_dimension' => '影像尺寸 Y',
               'sensing_method' => '检测方法',
                'exposure_mode' => '曝光模式',
                'white_balance' => '白平衡',
    'focal_length_in_35mm_film' => '等价35mm焦距',
           'scene_capture_type' => '情景拍摄类型',
             'gps_latitude_ref' => 'GPS纬度参考',
                 'gps_latitude' => 'GPS纬度参考',
            'gps_longitude_ref' => 'GPS经度参考',
                'gps_longitude' => 'GPS经度参考',
             'gps_altitude_ref' => 'GPS高度参考',
                 'gps_altitude' => 'GPS高度参考',
               # 'gps_time_stamp' => 'gps_time_stamp',
        'gps_img_direction_ref' => 'GPS图像方向参考',
            'gps_img_direction' => 'GPS图像方向'
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
    
    module ClassMethods
      # 取类名
      def ttt
        "hi this tui"
      end
    end
  end
end