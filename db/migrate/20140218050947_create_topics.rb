class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :last_user_id
      t.string :title
      t.string :content
      t.integer :comments_count, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
