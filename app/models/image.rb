class Image < ActiveRecord::Base
  has_many :des
  attr_accessible :album_id, :exif, :name, :user_id, :picture, :del
  # type 头像, 背景模板, (相册, 作品, 活动)
  # 头像有原图,大图(100x100),中图(50x50),小图(30x30或者其他尺寸)
  # 模板只有原图
  # 相册还有封面图(就是小图)
  # 相册,作品,活动就是原图,大图(400x600), 中图(200x300), 小图(50x60/ 50x50/ 60x60)
  # 需要设置访问权限

  has_attached_file :picture,
    styles: {
      big: "600x600>",
      thumbnail: '300x300>',
      small: '100x100>',
      s60: '60x60>',
      s50: '50x50>',
      s30: '30x30>'
    },
    url: "/system/:class/:attachment/:id/:basename/:style.:extension",
    path: ":rails_root/public/system/:class/:attachment/:id/:basename/:style.:extension",
    default_url: "/images/defaults/:class.jpg",
    :whiny => false

  # validates_attachment :picture,
    # presence: { presence: true, message: 'presence'},
    # content_type: { content_type: ["image/jpg", "image/jpeg", "image/gif", "image/png"], message: 'test' },
    # size: { :in => （0..10).kilobytes }

  # 通过哪里上传,就是哪个type 暂时定为全部一种style(s10,s20,s60,s110...)
  # ['Bg', 'Album', 'Avatar', 'Work', 'Event'].each do |row|
  #   class_eval "class #{row} < self; end"
  # end
end
