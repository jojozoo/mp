# == Schema Information
#
# Table name: mail_invites
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  email      :string(255)
#  username   :string(255)
#  isview     :boolean
#  isclick    :integer
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MailInvite < ActiveRecord::Base
  attr_accessible :uid,  
  :email, 
  :username,  
  :isview,
  :isclick, 
  :del
end
