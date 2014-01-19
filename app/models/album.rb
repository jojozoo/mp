class Album < ActiveRecord::Base
  attr_accessible :desc, :name, :open, :user_id
  # open 所有人 联系人 仅自己
  has_many :images

  validates_presence_of :name, message: '不能为空'
end
