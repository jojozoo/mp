# == Schema Information
#
# Table name: micros
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  name          :string(255)
#  title         :string(255)
#  text          :string(255)
#  source_id     :integer
#  source_type   :string(255)
#  source_name   :string(255)
#  source_title  :string(255)
#  source_text   :string(255)
#  sourcer_id    :integer
#  sourcer_type  :string(255)
#  sourcer_name  :string(255)
#  sourcer_title :string(255)
#  sourcer_text  :string(255)
#  refer_id      :integer
#  refer_type    :string(255)
#  refer_name    :string(255)
#  refer_title   :string(255)
#  refer_text    :string(255)
#  referer_id    :integer
#  referer_type  :string(255)
#  referer_name  :string(255)
#  referer_title :string(255)
#  referer_text  :string(255)
#  extra_id      :integer
#  extra_type    :string(255)
#  extra_name    :string(255)
#  extra_title   :string(255)
#  extra_text    :string(255)
#  extraer_id    :integer
#  extraer_type  :string(255)
#  extraer_name  :string(255)
#  extraer_title :string(255)
#  extraer_text  :string(255)
#  del           :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Micro < ActiveRecord::Base
  attr_accessible :user_id,
  :name,
  :title,
  :text,
  :source_id,
  :source_type,
  :source_name,
  :source_title,
  :source_text,
  :sourcer_id,
  :sourcer_type,
  :sourcer_name,
  :sourcer_title,
  :sourcer_text, 
  :refer_id,
  :refer_type,
  :refer_name,
  :refer_title,
  :refer_text,
  :referer_id,
  :referer_type,
  :referer_title,
  :referer_name,
  :referer_text,
  :extra_id,
  :extra_type,
  :extra_name,
  :extra_title,
  :extra_text,
  :extraer_id,
  :extraer_type,
  :extraer_name,
  :extraer_title,
  :extraer_text

  # 关联至动态产生者
  belongs_to :feeder, polymorphic: true

  # source是指主要的内容，如动态 图片 作品
  # refer 是指内容的回复，如动态 图片 作品 的评论
  # extra是附加内容
  belongs_to :source, polymorphic: true
  belongs_to :refer, polymorphic: true
  belongs_to :extra, polymorphic: true

  # 上述三种实体的拥有者
  belongs_to :sourcer, polymorphic: true
  belongs_to :referer, polymorphic: true
  belongs_to :extraer, polymorphic: true
end
