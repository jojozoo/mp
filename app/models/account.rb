# == Schema Information
#
# Table name: accounts
#
#  id            :integer          not null, primary key
#  uid           :string(255)
#  user_id       :integer
#  site          :string(255)
#  name          :string(255)
#  token         :string(255)
#  refresh_token :string(255)
#  expires_in    :string(255)
#  expires_at    :string(255)
#  other         :text
#  del           :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Account < ActiveRecord::Base
  attr_accessible :uid,
  :user_id, 
  :site, 
  :name, 
  :token, 
  :refresh_token, 
  :expires_in, 
  :expires_at, 
  :other,
  :del

  belongs_to :user
  
end
