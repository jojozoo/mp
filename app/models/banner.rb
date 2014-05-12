# == Schema Information
#
# Table name: banners
#
#  id                   :integer          not null, primary key
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  link                 :string(255)      default("javascript:void(0);")
#  title                :string(255)
#  desc                 :string(255)
#  del                  :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Banner < ActiveRecord::Base
  attr_accessible :picture, 
  :link, 
  :title, 
  :desc, 
  :del

  has_attached_file :picture
  
  validates_presence_of :picture, 
                        on: :create,
                        message: '不能为空'
end
