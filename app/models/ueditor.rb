# == Schema Information
#
# Table name: ueditors
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  del                  :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Ueditor < ActiveRecord::Base
  attr_accessible :user_id, :picture, :del
  has_attached_file :picture
end
