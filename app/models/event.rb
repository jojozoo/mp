class Event < ActiveRecord::Base
  attr_accessible :desc,
   :name,
   :logo, 
   :tag, 
   :end_time, 
   :works_count, 
   :members_count, 
   :totop, 
   :state, 
   :title, 
   :user_id, 
   :del
  # user_id 发起人
  # works_count: 图片数量
  # members_count 参与者数量
  # state 审核中 未通过 进行中 已结束(0,1,2,3)
  # totop 是否显示到全站导航
  # logo
  # tag 暂时有同城,年度,一般
  # 导航显示方法
    # 1 推荐显示一般活动
    # 2 推荐显示同城活动
    # 3 推荐显示年度活动
    # 4 正在进行的活动
    # 5 已结束的活动
  has_attached_file :logo,
    styles: {
      thumb: '200x200',
      small: '200x120'
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
                            
  # 作品 参与活动的作品
  has_many :works
  # 参与活动的图片
  has_many :images, through: :work, source: :image
  # 参与活动的人
  has_many :members, through: :work, source: :user
  # 活动获奖的人 大于0 asc排序: 0参与 1等奖 2等奖
  has_many :winners, :class_name => 'User', :conditions => '`works`.`winner` > 0'
  # 发起活动的人
  belongs_to :user
  # 作品 参与活动的作品
  has_many :topics

  STATE = {
    audit:   '审核中', # 0
    not_by:  '未通过', # 1
    ongoing: '进行中', # 2
    closed:  '已结束'  # 3
  }
  # STATEVAL = Hash[Array.new(4){|index| [index, STATE.values[index]]}]
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

  TOTOP = {
    0 => '未置顶',
    1 => '首页',
    2 => '导航',
    3 => '导航&首页'
  }

  # 活动不应该有类型
  # TAG = {
  #   eyear: '年度活动',
  #   ecity: '同城活动',
  #   eany:  '一般活动'
  # }

  
end

