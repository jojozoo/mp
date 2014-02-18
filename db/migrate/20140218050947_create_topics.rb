class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.integer :group_id
      t.string :title
      t.string :content
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
