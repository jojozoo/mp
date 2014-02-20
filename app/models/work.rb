class Work < ActiveRecord::Base
  attr_accessible :del, :event_id, :cover_id, :title, :desc, :user_id, :warrant, :winner, :images_count

  belongs_to :cover, class_name: 'Image', foreign_key: :cover_id
  has_many   :images
  belongs_to :user
  belongs_to :event

  validates_presence_of     :cover_id, 
                            :message => '不能为空'
  validates_presence_of     :event_id,
                            :message => '不能为空'
  validates_presence_of     :title, 
                            :message => '不能为空'
  validates_presence_of     :desc, 
                            :message => '不能为空'

  # desc:SecureRandom.hex(30), user_id: 116, image_id: Image.limit(1).order('rand()').first.id
  
end
