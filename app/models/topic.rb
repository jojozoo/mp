# == Schema Information
#
# Table name: topics
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  cate_id         :integer
#  last_user_id    :integer
#  last_updated_at :datetime
#  original        :boolean          default(TRUE)
#  title           :string(255)
#  content         :text
#  coms_count      :integer          default(0)
#  del             :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Topic < ActiveRecord::Base
  attr_accessible :user_id, :cate_id, :last_user_id, :last_updated_at, :original, :title, :content, :coms_count, :del
  
  has_many :comments, as: :obj
  has_many :tagships, as: :obj
  
  belongs_to :user
  belongs_to :last_user, class_name: 'User', foreign_key: :last_user_id
  has_many :visits, as: :obj

  belongs_to :cate, class_name: 'Tag', foreign_key: :cate_id


  validates_presence_of     :user_id, 
                            message: '不能为空'

  validates_presence_of     :title, 
                            message: '不能为空'

  validates_length_of       :title,
                            within: 3..20,
                            message: '长度3..20字'

  validates_presence_of     :content,
                            message: '不能为空'

  # validates_length_of       :content,
  #                           within: 10..300,
  #                           message: '长度10..300字'

  validates_presence_of     :cate_id,
                            message: '不能为空'

  # after_save :download_image, if {|r| r.content_changed?}
  # def download_image
    
  # end
end
