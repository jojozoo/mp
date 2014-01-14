class De < ActiveRecord::Base
  attr_accessible :desc, :image_id, :source_id, :source_type
  
  belongs_to :source, :polymorphic => true
  belongs_to :image
end
