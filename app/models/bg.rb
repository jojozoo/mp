class Bg < ActiveRecord::Base
  attr_accessible :name, :repeat, :user_id
  
  has_attached_file :name,
    styles: {
      thumb: '200x200'
    },
    url: "/system/bgs/:attachment/:id/:basename/:style.:extension",
    path: ":rails_root/public/system/bgs/:attachment/:id/:basename/:style.:extension",
    default_url: "/images/defaults/bg.jpg"

  # repeat
  # repeat      默认。背景图像将在垂直方向和水平方向重复。
  # repeat-x    背景图像将在水平方向重复。
  # repeat-y    背景图像将在垂直方向重复。
  # no-repeat   背景图像将仅显示一次。
  # inherit     规定应该从父元素继承 background-repeat 属性的设置。
  # require 'open-uri'
  # class Photo < ActiveRecord::Base
  #   belongs_to :user
  #   has_attached_file :image
  #   attr_accessor :image_url
  #   before_validation :download_remote_image, :if => :image_url_provided?
  #   validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => '地址不合法'

  #   private
  #   def image_url_provided?
  #     !self.image_url.blank?
  #   end
   
  #   def download_remote_image
  #     self.image = do_download_remote_image
  #     self.image_remote_url = image_url
  #   end
   
  #   def do_download_remote_image
  #     io = open(URI.parse(image_url))
  #     def io.original_filename; base_uri.path.split('/').last; end
  #     io.original_filename.blank? ? nil : io
  #   rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  #   end
  # end
  
  # user = User.first  
  # File.open('path/to/image.png', 'rb') { |photo_file| user.photo = photo_file }
  # user.save 
end
