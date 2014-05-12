# == Schema Information
#
# Table name: infos
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  site       :string(255)
#  path       :string(255)
#  nickname   :string(255)
#  local      :string(255)
#  email      :string(255)
#  gender     :string(255)
#  domain     :string(255)
#  desc       :string(255)
#  func       :string(255)
#  tag        :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Info < ActiveRecord::Base
  establish_connection :master
  attr_accessible :uid, 
  :site, 
  :path, 
  :nickname, 
  :local, 
  :email, 
  :gender, 
  :domain, 
  :desc, 
  :func, 
  :tag, 
  :isview,
  :isclick, 
  :del
end
