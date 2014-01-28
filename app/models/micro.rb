class Micro < ActiveRecord::Base
  attr_accessible :feeder_id,
  :feeder_type,
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
