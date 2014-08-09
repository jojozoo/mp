class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :title
      t.integer :user_id
      t.attachment :logo
      t.text :desc
      t.string :channel # 类型暂定
      t.boolean :ischannel, default: false
      t.date :end_time
      t.integer :members_count, default: 0
      t.integer :photos_count, default: 0
      t.integer :state, default: 0
      t.boolean :totop, default: 0
      t.boolean :request, default: false # 排序使用
      t.datetime :request_at
      t.integer :coms_count, default: 0 # 回应数量
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
