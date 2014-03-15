# == Schema Information
#
# Table name: sbgs
#
#  id                 :integer          not null, primary key
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  bg                 :boolean          default(TRUE)
#  del                :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Sbg < ActiveRecord::Base
	attr_accessible :photo, :bg, :del
	# 为两种背景 一种登录背景和sign背景
    has_attached_file :photo
    scope :bgs, -> {where(bg: true)}
    scope :signs, -> {where(bg: false)}

    validates_presence_of :photo, 
    					on: :create,
                        message: '不能为空'
end
