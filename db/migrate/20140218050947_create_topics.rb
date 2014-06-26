class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.integer :cate_id
      t.integer :last_user_id
      t.datetime :last_updated_at
      t.boolean :original, default: true
      t.string :title
      t.text :content
      t.integer :coms_count, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
