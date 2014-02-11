class Album < ActiveRecord::Base
  attr_accessible :desc, :logo, :name, :open, :user_id
  # open 所有人 联系人 仅自己
  has_many :images
  has_attached_file :logo,
    styles: {
      thumb: '260x180#',
      small: '200x120#'
    }

  validates_presence_of   :name, 
                          message: '不能为空'

  validates_uniqueness_of :name, 
                          :scope => :user_id,
                          :message => '相册已存在'

  validates_length_of     :name, 
                          :within => 1..20,
                          :message => '长度1..20字'
end
