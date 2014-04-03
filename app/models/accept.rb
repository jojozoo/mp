# == Schema Information
#
# Table name: accepts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  followd_mail   :boolean          default(FALSE)
#  recom_mail     :boolean          default(FALSE)
#  like_mail      :boolean          default(FALSE)
#  store_mail     :boolean          default(FALSE)
#  comment_mail   :boolean          default(FALSE)
#  msg_mail       :boolean          default(FALSE)
#  followd_notice :boolean          default(FALSE)
#  recom_notice   :boolean          default(FALSE)
#  like_notice    :boolean          default(FALSE)
#  store_notice   :boolean          default(FALSE)
#  comment_notice :boolean          default(FALSE)
#  msg_notice     :boolean          default(FALSE)
#  del            :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Accept < ActiveRecord::Base
  attr_accessible :user_id, 
  :comment_mail, 
  :followd_mail, 
  :like_mail, 
  :msg_mail, 
  :recom_mail, 
  :store_mail, 
  :comment_notice, 
  :followd_notice, 
  :like_notice, 
  :msg_notice, 
  :recom_notice, 
  :store_notice

  TIP = {
    followd: '被关注',
    recom:   '被推荐',
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
