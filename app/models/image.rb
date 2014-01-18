require 'paperclip_processors/watermark'
class Image < ActiveRecord::Base
  has_many :des
  attr_accessible :album_id, :warrant, :exif, :name, :user_id, :picture, :picture_meta, :del
  # type 头像, 背景模板, (相册, 作品, 活动)
  # 头像有原图,大图(100x100),中图(50x50),小图(30x30或者其他尺寸)
  # 模板只有原图
  # 相册还有封面图(就是小图)
  # 相册,作品,活动就是原图,大图(400x600), 中图(300x300), 小图(50x60/ 50x50/ 60x60)
  # 需要设置访问权限
  # 几种水印图, 原图无水印,原图水印,大图水印, 中图水印, 小图中间水印, 头像, 50x50无水印
  # cover 封面
  # 活动上传完是消息，之后是回应

  has_attached_file :picture,
    processors: [:watermark],
    styles: {
      original_water: {
        :geometry => '600x400>',
        :watermark_path => "#{Rails.root}/public/images/logo.png", # 水印图片所在位置
        # :position => 'Center' # 添加的水印在图片哪个位置
      },
      big: "600x600>",
      thumbnail: '300x300>',
      cover: '260x180#',
      small: '100x100>',
      s60: '60x60>',
      s50: '50x50>',
      s30: '30x30>'
    },
    url: "/system/:class/:attachment/:id/:basename/:style.:extension",
    path: ":rails_root/public/system/:class/:attachment/:id/:basename/:style.:extension",
    default_url: "/images/defaults/:class.jpg",
    :whiny => false

    # before_post_process
    # after_post_process
    # before_<attachment>_post_process
    # after_<attachment>_post_process
    # 官方说尽可能和activerecord的filter一样,但是返回false(特别是nil), 是不一样的,这个post process将停止



  # validates_attachment :picture,
    # presence: { presence: true, message: 'presence'},
    # content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"], message: 'test' },
    # size: { :in => （0..10).kilobytes }

  # 通过哪里上传,就是哪个type 暂时定为全部一种style(s10,s20,s60,s110...)
  # ['Bg', 'Album', 'Avatar', 'Work', 'Event'].each do |row|
  #   class_eval "class #{row} < self; end"
  # end
end
