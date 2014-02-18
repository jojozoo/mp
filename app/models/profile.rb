class Profile < ActiveRecord::Base
  attr_accessible :del, :pmail, :psite, :user_id
end
