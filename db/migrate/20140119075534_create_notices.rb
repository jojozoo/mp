class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.integer :user_id
      t.integer :send_id
      t.string :title
      t.text :content
      t.boolean :read
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
