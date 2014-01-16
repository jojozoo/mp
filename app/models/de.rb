class De < ActiveRecord::Base
  attr_accessible :desc, :image_id, :source_id, :user_id, :source_type
  
  belongs_to :source, :polymorphic => true
  belongs_to :image
  belongs_to :user
end
