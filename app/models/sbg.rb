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