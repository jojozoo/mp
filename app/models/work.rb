# == Schema Information
#
# Table name: works
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  cover_id       :integer
#  photos_count   :integer          default(0)
#  comments_count :integer          default(0)
#  visit_count    :integer          default(0)
#  title          :string(255)
#  desc           :string(255)
#  del            :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Work < ActiveRecord::Base
  attr_accessible :user_id, 
  :cover_id, 
  :photos_count, 
  :comments_count, 
  :visit_count, 
  :title, 
  :desc, 
  :del

  # belongs_to :cover, class_name: 'Photo', foreign_key: :cover_id
  # has_many   :photos
  # belongs_to :user
  # belongs_to :event
  # has_many   :visits, as: :obj
  # has_many   :comments, as: :obj, order: 'id desc'

  # validates_presence_of     :cover_id, 
  #                           :message => '不能为空'
  # validates_presence_of     :event_id,
  #                           :message => '不能为空'
  # validates_presence_of     :title, 
  #                           :message => '不能为空'
  # validates_presence_of     :desc, 
  #                           :message => '不能为空'

  # desc:SecureRandom.hex(30), user_id: 116, image_id: Photo.limit(1).order('rand()').first.id
  
end
