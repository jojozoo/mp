class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :talk_id
      t.integer :user_id
      t.string :content
      t.integer :del, default: false

      t.timestamps
    end
  end
end
