class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :follower_id
      t.string :mark
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
