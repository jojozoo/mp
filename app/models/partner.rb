class Partner < ActiveRecord::Base
  attr_accessible :event_id, :level, :user_id, :winner

  belongs_to :event
  belongs_to :user
  has_many :de, as: :source
  has_many :images, through: :de, source: :image
end
