class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :auth, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
