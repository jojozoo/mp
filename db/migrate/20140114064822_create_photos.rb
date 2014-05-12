class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :work_id # 为用户分作品时用到
      t.integer :album_id
      t.integer :groupid # 不好看 但也不知道怎么换
      t.boolean :state, default: 0 # 状态
      t.boolean :editor, default: 0 # 是否被编辑查看

      t.integer :score,      default: 0 # 用于排序，如:喜欢一次+10分，收藏一次+20
      t.integer :recs_count, default: 0 # 推荐数量
      t.integer :liks_count, default: 0 # 喜欢数量
      t.integer :stos_count, default: 0 # 收藏数量
      t.integer :vist_count, default: 0 # 浏览数量
      t.integer :coms_count, default: 0 # 回应数量
       
      # 推荐是编辑或者管理员行为 不记录数量
      t.boolean :recommend, default: false # 是否推荐 
      t.datetime :recommend_at
      t.boolean :choice, default: false    # 是否精选 -> 每日一图
      t.datetime :choice_at
      
      t.attachment :picture
      t.string :name
      t.string :title
      t.string :desc
      t.integer :warrant   # 授权
      t.string :randomhex  # 用于随机浏览使用
      t.string :randomstr  # 用于原图加密使用
      t.text   :exif       # 可能要单独建表
      t.string :wh
      t.boolean :del, default: false
      t.timestamps
    end
  end
end
