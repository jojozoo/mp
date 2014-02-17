class Ad < ActiveRecord::Base
  attr_accessible :photo, :title, :desc, :target, :t, :s, :b, :c, :f, :del
  # photo      图片
  # title      标题
  # desc       描述
  # target     跳转地址
  # t(type)    类型(图片,视频)
  # s(show)    显示方式(固定,居左,居右)
  # TODO 浏览 点击 来源应该单独建表
  # TODO 修改时有bug
  has_attached_file :photo

  has_many :putins#, -> { where(del: false) }
  validates_presence_of :photo,
                        on: :create,
                        message: '不能为空'
  validates_presence_of :target, :t, :s,
                        message: '不能为空'
  
  ADTYPE = {
    0 => '图片'
  }

  ADSHOW = {
    0 => '固定'
  }
end
