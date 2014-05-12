class CreateTagships < ActiveRecord::Migration
  def change
    create_table :tagships do |t|
      t.references :obj, polymorphic: true # 文章 图片 用户都可以拥有tag
      t.string  :name    # 冗余字段，方便搜索 更新tag更新对应的ship，更新索引
      t.string  :channel # 冗余字段，方便搜索 更新tag更新对应的ship，更新索引
      t.integer :tag_id
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
