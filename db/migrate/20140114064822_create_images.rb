class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :user_id
      t.integer :album_id
      t.integer :event_id
      t.integer :state, default: 0 # 状态(上传完成:某一活动跳转了,回来应该接着显示,如果不完成,那么就不显示到活动页) state改变注定album_id 或event_id有值
      t.integer :warrant # 授权
      t.attachment :picture
      t.string :title
      t.text   :text
      t.text :exif
      t.boolean :del, default: false
      t.timestamps
    end
  end
end
