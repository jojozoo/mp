class CreateTuis < ActiveRecord::Migration
  def change
    create_table :tuis do |t|
      t.references :obj, polymorphic: true    
      t.references :source, polymorphic: true # 用于推荐慢拍之星或者摄影师
      t.string :channel    # 包含喜欢 收藏 推荐 自荐 精选 慢拍之星 推荐摄影师 其中photos表要加对应时间戳和boolean类型
      # visit 是否可以加入 就算不加入也是不能一个资源有多条记录
      t.integer :user_id   # 原用于推荐者id，阻止编辑二次推荐 现为obj所属用户ID
      t.integer :editor    # 管理员 编辑 普通用户
      t.integer :editor_id # 管理员 编辑 普通用户
      t.string :mark
      t.boolean :del, default: false

      t.timestamps
    end
    # add_index :tuis, :obj_id
  end
end
