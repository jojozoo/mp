class Ueditor < ActiveRecord::Base
  attr_accessible :user_id, :picture, :del
  has_attached_file :picture
end
