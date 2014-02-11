class Feedback < ActiveRecord::Base
  attr_accessible :email, :name, :subject, :desc, :user_id, :ip
  validates_presence_of     :email,
                            :message => '邮箱不能为空'

  validates_format_of       :email, 
                            :with  => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/,
                            :message => '邮箱格式不正确'

  validates_presence_of     :name,
                            :message => '姓名不能为空'

  validates_length_of       :name, 
                            :within => 2..10,
                            :message => '姓名长度2..10位'

  validates_presence_of     :desc,
                            :message => '内容不能为空'

  validates_length_of       :desc, 
                            :within => 10..200,
                            :message => '内容长度10..200字'
end
