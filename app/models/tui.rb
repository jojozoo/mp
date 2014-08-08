# == Schema Information
#
# Table name: tuis
#
#  id         :integer          not null, primary key
#  obj_id     :integer
#  obj_type   :string(255)
#  channel    :string(255)
#  user_id    :integer
#  editor     :integer
#  editor_id  :integer
#  event_id   :integer
#  day        :string(255)
#  mark       :string(255)
#  del        :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tui < ActiveRecord::Base
  attr_accessible :obj_id, 
  :obj_type, 
  :channel,
  :user_id,
  :editor,
  :editor_id,
  :event_id,
  :day,
  :mark, 
  :del

  # TODO 编辑推荐存在重复性 即一个管理员一次推荐会记录一次，哪怕是重复资源
  # TODO 一次取消编辑推荐说明作品不值得推荐，那么就应该删除对应的推荐属性
  
  # 编辑推荐数 喜欢数之类的
  belongs_to :obj, polymorphic: true#, counter_cache: true
  belongs_to :user

  # validates_uniqueness_of :editor_id, 
  #                         :scope => [:obj_type, :obj_id],
  #                         :message => '重复操作'

  # TIP = {
  #   followd: '被关注',
  #   recom:   '被推荐',
  #   like:    '被喜欢',
  #   store:   '被收藏',
  #   comment: '被回应',
  #   msg:     '收到私信'
  # }
  
  RECOMMENDEDTYPE = {
    'liks'          => '喜欢',
    'stos'         => '收藏',
    'recommend'     => '编辑推荐',
    'selfrecommend' => '自荐',
    'choice'        => '封面大图',
    # 'star'          => '漫拍之星',
    # 'photographer'  => '推荐摄影师',
    'request'       => '推荐活动'
  }
  RECOMMENDEDTYPE.each do |key, value|
    # 对应的obj_type和id找到对应的资源
    # (obj_type.downcase + '_path').to_sym(obj_id)
    scope key, -> {where(channel: key)}
  end

  after_create :create_notice
  def create_notice
    cate = {"recommend"=>"recommend", "choice"=>"choice", "liks"=>"like", "stos"=>"store", "coms"=>"comment", "fols"=>"fol"}[self.channel]
    Notice.add_once cate, self.user_id, self.editor_id, self.obj_id, self.obj_type if cate and self.user_id != self.editor_id
  end

  # 编辑推荐 封面大图 喜欢 收藏
  def self.cho_or_rec cate, photo, editer, iseditor = false
    attrs = {obj_id: photo.id, obj_type: 'Photo', channel: cate, editor: iseditor }
    # 如果是编辑推荐或者封面大图,这里不限制谁做的操作
    # 编辑的3次编辑推荐机会有点问题，别人撤销了编辑推荐，那么此用户还有一次编辑推荐的机会
    attrs.merge!(editor_id: editer.id) unless iseditor
    tui = Tui.where(attrs).first
    upattrs = if tui
      tip = '取消成功'
      tui.destroy
      res_attrs(cate, true, photo)
    else
      tip = '操作成功'
      Tui.create!(attrs.merge({user_id: photo.user_id, event_id: photo.event_id, day: Date.today.to_s(:number), editor_id: editer.id}))
      content = {'recommend' => '将此作品推荐为编辑推荐', 'choice' => '将此作品推荐为封面大图', 'stos' => '收藏了此作品', 'liks' => '喜欢了此作品'}[cate]
      Comment.create(obj_id: photo.id, obj_type: 'Photo', user_id: editer.id, content: content) if content
      res_attrs(cate, false, photo)
    end
    photo.update_attributes(upattrs)
    {text: tip, type: 'success'}
  end

  def self.res_attrs cate, real, photo
    {
      'recommend' => {recommend: !real, recommend_at: Time.now},
      'choice'    => {choice: !real, choice_at: Time.now},
      'liks'      => {liks_count: real ? photo.liks_count - 1 : photo.liks_count + 1},
      'stos'      => {stos_count: real ? photo.stos_count - 1 : photo.stos_count + 1}
    }[cate]
  end
  

end
