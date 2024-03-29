class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :user_id
      t.attachment :logo
      t.string :title
      t.text :desc
      t.string :channel # 类型暂定
      t.date :end_time
      t.integer :members_count, default: 0
      t.integer :works_count, default: 0
      t.integer :images_count, default: 0
      t.integer :state, default: 0
      t.boolean :totop, default: false
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
