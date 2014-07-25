# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  user_id    :integer
#  reply_id   :integer
#  title      :string(255)
#  content    :text
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :obj_id, 
  :obj_type, 
  :user_id, 
  :reply_id, 
  :title, 
  :content, 
  :del

  belongs_to :obj, polymorphic: true, counter_cache: :coms_count
  belongs_to :user
  belongs_to :reply, class_name: 'User', foreign_key: :reply_id

  validates_presence_of     :content, 
                            :message => '不能为空'

  validates_length_of       :content,
                            :within => 1..200,
                            :message => '长度1..200字'

  after_create :create_notice
  def create_notice 
    return if self.reply_id == self.user_id
    if self.reply_id.present?
      Notice.add_once 'reply', self.reply_id, self.user_id, self.obj_id, self.obj_type
    else
      # 非系统自动回复的发通知
      # 应该加个字段来标识是否系统产生，来达到是否要发送通知
      Notice.add_once 'comment', self.obj.user_id, self.user_id, self.obj_id, self.obj_type unless ['将此作品推荐为精选', '将此作品推荐为每日一图', '收藏了此作品', '喜欢了此作品'].member?(self.content)
    end
  end

end
