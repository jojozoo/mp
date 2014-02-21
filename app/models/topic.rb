class Topic < ActiveRecord::Base
  attr_accessible :content, :del, :group_id, :title, :user_id, :comments_count

  has_many :comments
  belongs_to :group
  belongs_to :user


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
                            message: '长度10..200字'

  validates_presence_of     :group_id,
                            message: '不能为空'
end
