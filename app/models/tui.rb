class Tui < ActiveRecord::Base
  belongs_to :obj
  attr_accessible :del, :mark, :type, :user_id
end
