class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :obj, polymorphic: true
      t.integer :user_id
      t.integer :send_id
      t.string :title
      t.text :content
      t.string :cate
      t.boolean :read, default: false
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
