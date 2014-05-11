class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :sum
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
