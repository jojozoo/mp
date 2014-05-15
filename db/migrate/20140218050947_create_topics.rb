class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.integer :owner_id
      t.integer :last_user_id
      t.datetime :last_updated_at
      t.boolean :emphasis, default: 0
      t.datetime :emphasis_at
      t.string :title
      t.string :content
      t.integer :coms_count, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
