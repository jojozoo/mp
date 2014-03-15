class Accept < ActiveRecord::Base
  attr_accessible :user_id, 
  :comment_mail, 
  :followd_mail, 
  :laud_mail, 
  :like_mail, 
  :msg_mail, 
  :recom_mail, 
  :store_mail, 
  :comment_notice, 
  :followd_notice, 
  :laud_notice, 
  :like_notice, 
  :msg_notice, 
  :recom_notice, 
  :store_notice

  TIP = {
    followd: '被关注',
    recom:   '被推荐',
    laud:    '被点赞',
    like:    '被喜欢',
    store:   '被收藏',
    comment: '被回应',
    msg:     '收到漫信'
  }

  # 发送类型, 发送对象
  def push tp, obj
    # 确定发送邮件还是通知
  end

end
