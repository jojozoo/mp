# == Schema Information
#
# Table name: events
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  title             :string(255)
#  user_id           :integer
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  desc              :text
#  channel           :string(255)
#  end_time          :date
#  members_count     :integer          default(0)
#  photos_count      :integer          default(0)
#  state             :integer          default(0)
#  totop             :boolean          default(FALSE)
#  request           :boolean          default(FALSE)
#  request_at        :datetime
#  del               :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Event < ActiveRecord::Base
  attr_accessible :name,
   :title,
   :user_id, 
   :logo, 
   :desc, 
   :channel, 
   :end_time,
   :members_count,
   :photos_count, 
   :state, 
   :totop,
   :request,
   :request_at,  
   :del
  # user_id 发起人
  # state 审核中 未通过 进行中 已结束(0,1,2,3)
  # channel 暂时有同城,年度,手机
  # 导航显示方法
    # 1 推荐显示一般活动
    # 2 推荐显示同城活动
    # 3 推荐显示年度活动
    # 4 正在进行的活动
    # 5 已结束的活动
  CHANNEL = {
    0 => '年度',
    1 => '同城',
    2 => '手机'
  }
  has_attached_file :logo,
    styles: {
      big: '800x600>',
      thumb: '280x210#'
    }

  validates_presence_of     :name, 
                            :message => '不能为空'

  validates_uniqueness_of   :name, 
                            :message => '名称已经被占用'

  validates_length_of       :name,
                            :within => 3..10,
                            :message => '长度3..10字'

  validates_presence_of     :title, 
                            :message => '不能为空'
  
  validates_length_of       :title,
                            :within => 3..20,
                            :message => '长度3..20字'

  validates_presence_of     :desc, 
                            :message => '不能为空'
  
  validates_length_of       :desc,
                            :within => 10..1000,
                            :message => '长度10..1000字'

  validates_presence_of     :end_time,
                            :message => '不能为空'

  # 修改活动 增加tag
  after_save :add_to_tag, if: Proc.new{|r| r.state_changed? }
  def add_to_tag
    tag = Tag.unscoped.find_or_create_by_name_and_channel(self.name, '活动')
    tag.update_attributes(del: !self.ongoing?)
  end

  
  # 参与活动的人 如何需要显示后期再加，现在是editor编辑者
  # has_many :members
  has_many :editors#, foreign_key: :editor_id
  # event_id, user_id, images_count, winner, auth(editor, other)
  # 活动获奖的人 大于0 asc排序: 0参与 1等奖 2等奖
  has_many :photos
  # 活动的文章 但是创建文章的时候应该如何关联？ 只在后台有权限关联好了，前台只可以添加活动标签
  has_many :topics, foreign_key: :owner_id
  # 发起活动的人 publisher
  belongs_to :user

  scope :request, -> {where(request: true)}
  scope :totop, -> {where(totop: true).order('updated_at desc').limit(4)}

  STATE = {
    audit:   '审核中', # 0
    not_by:  '未通过', # 1
    ongoing: '进行中', # 2
    closed:  '已结束'  # 3
  }

  STATE.keys.each_with_index do |key, index|
    scope key, -> {where(state: index)}
    # instance_eval
    class_eval <<-STATE_METHOD
      def #{key}?
        state.eql?(#{index})
      end
      def #{key}!
        update_attributes(state: #{index})
      end
    STATE_METHOD
  end

  
end

