class Work < ActiveRecord::Base
  attr_accessible :del, :event_id, :image_id, :text, :title, :user_id, :warrant, :winner

  belongs_to :image
  belongs_to :user
  belongs_to :user
  
end
