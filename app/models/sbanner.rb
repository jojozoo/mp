# == Schema Information
#
# Table name: sbanners
#
#  id                 :integer          not null, primary key
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  link               :string(255)      default("javascript:void(0);")
#  title              :string(255)
#  desc               :string(255)
#  del                :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Sbanner < ActiveRecord::Base
    attr_accessible :photo, :link, :title, :desc, :del
    has_attached_file :photo
	# require 'open-uri'
	# io = open(URI.parse(image_url))
	# Bg.create(name: File.open('public/images/body01.jpg')).name.url
	# File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
	# user.save
  
  validates_presence_of :photo, 
  						on: :create,
                        message: '不能为空'
end
