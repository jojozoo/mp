class User < ActiveRecord::Base
  attr_accessible :city, :email, :mobile, :nickname, :password, :province, :remember_me, :salt, :username
  
end
