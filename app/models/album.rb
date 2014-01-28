class Album < ActiveRecord::Base
  attr_accessible :desc, :logo, :name, :open, :user_id
  # open 所有人 联系人 仅自己
  has_many :images
  has_attached_file :logo,
    styles: {
      thumb: '200x200',
      small: '200x120'
    },
    url: "/system/albums/:attachment/:id/:basename/:style.:extension",
    path: ":rails_root/public/system/albums/:attachment/:id/:basename/:style.:extension",
    default_url: "/images/defaults/album.jpg"

  validates_presence_of :name, message: '不能为空'
end
