class Bg < ActiveRecord::Base
  attr_accessible :name, :repeat, :user_id, :admin
  
  has_attached_file :name
  # 只有管理员上传的才能做为bg

  # repeat
  # repeat      默认。背景图像将在垂直方向和水平方向重复。
  # repeat-x    背景图像将在水平方向重复。
  # repeat-y    背景图像将在垂直方向重复。
  # no-repeat   背景图像将仅显示一次。
  # require 'open-uri'
  # io = open(URI.parse(image_url))
  # Bg.create(name: File.open('public/images/body01.jpg')).name.url
  # File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
  # user.save
  
end
