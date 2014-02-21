class Member < ActiveRecord::Base
  attr_accessible :auth, :del, :group_id, :user_id

  belongs_to :group
  belongs_to :user
  # auth(2创建 1管理 0成员)
end
