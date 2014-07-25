# == Schema Information
#
# Table name: notices
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  user_id    :integer
#  send_id    :integer
#  title      :string(255)
#  content    :text
#  cate       :string(255)
#  read       :boolean          default(FALSE)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notice < ActiveRecord::Base
  # 通知的发送者只能是系统, 所以send_id没有用处
  attr_accessible :obj_id, :obj_type, :user_id, :send_id, :title, :content, :cate, :read, :del

  CATE = {
    'recommend' => '推荐 ',
    'choice' => '每日一图 ',
    'like' => '喜欢',
    'store' => '收藏 ',
    'comment' => '回应',
    'reply' => '回复',
    'fol' => '关注'
  }
  belongs_to :obj, polymorphic: true
  belongs_to :user
  belongs_to :sender, class_name: 'User', foreign_key: :send_id

  def self.add_once cate, user_id, sender_id = 0, obj_id, obj_type
    self.create(obj_id: obj_id, obj_type: obj_type, user_id: user_id, send_id: sender_id, cate: cate) unless user_id == sender_id # 非用户自己对自己的操作
  end
end
