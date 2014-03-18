# == Schema Information
#
# Table name: sends
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  channel    :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Send < ActiveRecord::Base
  attr_accessible :title, :content, :channel, :del
  # 全站通知表
  # channel 什么类型的通知
  # 通知表可以不存在, 在后台管理时有通知tab
  validates_presence_of :title, :content, :channel,
                        message: '不能为空'

  TAG = ['邮件','漫信','页面']

  scope :site, -> {where(channel: '页面')}
end
