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
    if self.reply_id.present? and self.reply_id != self.user_id
      Notice.add_once 'reply', self.reply_id, self.user_id, self.obj_id, self.obj_type
    else
      Notice.add_once 'comment', self.obj.user_id, self.user_id, self.obj_id, self.obj_type if self.obj.user_id != self.user_id
    end
  end

end
