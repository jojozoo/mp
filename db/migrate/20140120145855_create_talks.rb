class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.integer :user_id
      t.integer :sender_id
      t.string :text
      t.integer :state, default: 1
      t.integer :messages_count, default: 0
      t.boolean :del, default: 0

      t.timestamps
    end
  end
end