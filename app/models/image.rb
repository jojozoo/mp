# require 'paperclip_processors/watermark'
class Image < ActiveRecord::Base
  attr_accessible :album_id, :event_id, :warrant, :state, :exif, :name, :title, :text, :user_id, :picture, :del
  # 几种水印图, 原图无水印,原图水印,大图水印, 中图水印, 小图中间水印, 头像, 50x50无水印
  # cover 封面
  # 如果是图片后缀, 但不是图片, 那么图片会加载不起来, 要想办法统计到, 现在的方式是通过日志分析

  # 必须要在 public/images/water/目录存在相对应key的水印图
  Water = {
    big: "960x600>",
    thumb: '260x180>',
    cover: '260x180#',
    small: '100x100>'
  }
  # TODO 更新picture时自动获取exif信息 参考 paperclip.rb 文件
  # avatar 时自动获取宽高 参考 paperclip.rb 文件
  has_attached_file :picture,
    processors: [:watermark],
    styles: Hash[Water.map{|k,v| [k, {geometry: v, water_path: "#{Rails.root.to_s}/public/images/water/#{k}.jpg", quality: :better}]}]

  has_many :works

  after_picture_post_process :load_exif

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
  end

    # before_post_process
    # after_post_process
    # before_<attachment>_post_process
    # after_<attachment>_post_process
    # 官方说尽可能和activerecord的filter一样,但是返回false(特别是nil), 是不一样的,这个post process将停止
    
end
