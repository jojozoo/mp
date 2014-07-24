# == Schema Information
#
# Table name: notices
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  send_id    :integer
#  title      :string(255)
#  content    :text
#  read       :boolean          default(FALSE)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notice < ActiveRecord::Base
  # 通知的发送者只能是系统, 所以send_id没有用处
  attr_accessible :user_id, :send_id, :title, :content, :read, :del

  belongs_to :sender, class_name: 'User', foreign_key: :send_id
end
