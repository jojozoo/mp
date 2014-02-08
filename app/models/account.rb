class Account < ActiveRecord::Base
  attr_accessible :expires_at, :expires_in, :other, :refresh_token, :site, :token, :uid, :user_id

  belongs_to :user
  
end
