class SiteBg < ActiveRecord::Base
  attr_accessible :photo, :link, :title, :desc, :type, :del
  # type 什么类型 banner 还是 background 还是 sign
  # require 'open-uri'
  # io = open(URI.parse(image_url))
  # Bg.create(name: File.open('public/images/body01.jpg')).name.url
  # File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
  # user.save
  
end
