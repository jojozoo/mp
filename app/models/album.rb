# == Schema Information
#
# Table name: albums
#
#  id                :integer          not null, primary key
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  user_id           :integer
#  name              :string(255)
#  desc              :string(255)
#  publish           :boolean          default(TRUE)
#  del               :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Album < ActiveRecord::Base
  attr_accessible :desc, :logo, :name, :publish, :user_id
  # 相册不需要desc字段
  # publish 所有人 仅自己
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
