class Work < ActiveRecord::Base
  attr_accessible :del, :event_id, :image_id, :desc, :title, :user_id, :warrant, :winner

  belongs_to :image
  belongs_to :user
  belongs_to :event

  # desc:SecureRandom.hex(30), user_id: 116, image_id: Image.limit(1).order('rand()').first.id
  
end
