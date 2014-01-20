class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :talk_id
      t.integer :user_id
      t.string :text
      t.integer :del, default: 0

      t.timestamps
    end
  end
end
