require 'paperclip_processors/watermark'
class Image < ActiveRecord::Base
  has_many :des
  attr_accessible :album_id, :warrant, :state, :exif, :name, :user_id, :picture, :picture_meta, :del
  # type 头像, 背景模板, (相册, 作品, 活动)
  # 模板只有原图
  # 需要设置访问权限
  # 几种水印图, 原图无水印,原图水印,大图水印, 中图水印, 小图中间水印, 头像, 50x50无水印
  # cover 封面
  # 如果是图片后缀, 但不是图片, 那么图片会加载不起来, 要想办法统计到, 现在的方式是通过日志分析

  has_attached_file :picture,
    processors: [:watermark],
    styles: {
      water: {
        :geometry => '600x400>',
        :watermark_path => "#{Rails.root}/public/images/logo.png", # 水印图片所在位置
        # :position => 'Center' # 添加的水印在图片哪个位置
      },
      big: "900x600>",
      thumb: '260x180>',
      cover: '260x180#',
      small: '100x100>'
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
