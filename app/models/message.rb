class Message < ActiveRecord::Base
  attr_accessible :content, :from_id, :state, :to_id, :sdel, :fdel
  # fdel 发件人删除
  # sdel 收件人删除
  # 发件人
  belongs_to :sender, class_name: 'User', foreign_key: :from_id
  # 收件人
  belongs_to :iboxer, class_name: 'User', foreign_key: :to_id

end
