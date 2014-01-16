class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.integer :logo_id
      t.string :title
      t.text :content
      t.string :tag # 类型暂定
      t.date :end_time
      t.integer :partners_count, default: 0
      t.integer :images_count, default: 0
      t.integer :state, default: 0
      t.boolean :show, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
