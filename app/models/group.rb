class Group < ActiveRecord::Base
  attr_accessible :desc, :logo, :members_count, :publish, :title, :topics_count, :user_id, :visits_count

  has_attached_file :logo,
    styles: {
      thumb: '260x180#',
      small: '60x60#'
    }

  validates_presence_of     :logo,
                            on: :create,
                            message: '不能为空'

  validates_presence_of     :title, 
                            message: '不能为空'

  validates_length_of       :title,
                            :within => 5..30,
                            message: '长度5..30字'

  validates_presence_of     :desc,
                            message: '不能为空'

  validates_length_of       :desc,
                            :within => 10..200,
                            message: '长度10..200字'

  validates_presence_of     :publish,
                            message: '不能为空'


  has_many :topics
  has_many :members
  has_many :visits

  belongs_to :user

  after_create :create_founder
  def create_founder
    members.create(user_id: user_id, auth: 2)
  end

  # 针对group是否能发言
  def speak?(user)
    uid = user.is_a?(User) ? user.id : user
    members.exists?(user_id: uid)
  end
end
