class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :user_id
      t.integer :event_id
      t.integer :work_id
      t.integer :album_id
      t.integer :groupid
      t.boolean :state, default: 0 # 状态
      t.integer :visits_count, default: 0
      t.integer :likes_count, default: 0
      t.integer :stores_count, default: 0
      t.integer :recoms_count, default: 0
      t.integer :comments_count, default: 0

      t.integer :pushes_count, default: 0
      t.datetime :pushed_at
      t.boolean :choice, default: false
      t.datetime :choiced_at

      t.integer :warrant # 授权
      t.attachment :picture
      t.string :hex
      t.string :randomhex
      t.string :desc
      t.text   :exif
      t.string :wh
      t.boolean :del, default: false
      t.timestamps
    end
  end
end
