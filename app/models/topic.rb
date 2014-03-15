# == Schema Information
#
# Table name: topics
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  tag_id         :integer
#  last_user_id   :integer
#  title          :string(255)
#  content        :string(255)
#  comments_count :integer          default(0)
#  del            :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :content, :del, :tag_id, :title, :user_id, :last_user_id, :comments_count

  has_many :comments, as: :obj
  belongs_to :user
  belongs_to :tag
  belongs_to :last_user, class_name: 'User', foreign_key: :last_user_id
  has_many :visits, as: :obj


  validates_presence_of     :user_id, 
                            message: '不能为空'

  validates_presence_of     :title, 
                            message: '不能为空'

  validates_length_of       :title,
                            within: 3..20,
                            message: '长度3..20字'

  validates_presence_of     :content,
                            message: '不能为空'

  validates_length_of       :content,
                            within: 10..300,
                            message: '长度10..300字'

  validates_presence_of     :tag_id,
                            message: '不能为空'
end
