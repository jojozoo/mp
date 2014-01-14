class Image < ActiveRecord::Base
  has_many :des
  attr_accessible :exif, :name, :user_id, :picture, :del

  has_attached_file :picture,
  	:url => "/system/:class/:attachment/:id/:basename/:style.:extension",
  	:path => ":rails_root/public/system/:class/:attachment/:id/:basename/:style.:extension",
  	:default_url => "/images/defaults/:class.jpg"

 validates_attachment :picture,
  :presence => true,
  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] },
  :size => { :in => 0..10.kilobytes }
end
