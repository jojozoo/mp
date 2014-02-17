class Sbanner < ActiveRecord::Base
    attr_accessible :photo, :link, :title, :desc, :del
    has_attached_file :photo
	# require 'open-uri'
	# io = open(URI.parse(image_url))
	# Bg.create(name: File.open('public/images/body01.jpg')).name.url
	# File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
	# user.save
  
  validates_presence_of :photo, 
                        message: '不能为空'
end