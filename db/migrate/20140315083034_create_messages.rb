class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :user_id
      t.string  :talk
      t.integer :state     , default: 0
      t.integer :s_is_del  , default: 0
      t.integer :u_is_del  , default: 0
      t.string :content
      t.integer :del, default: false

      t.timestamps
    end
  end
end
