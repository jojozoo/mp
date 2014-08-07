class CreateUeditors < ActiveRecord::Migration
  def change
    create_table :ueditors do |t|
      t.integer :user_id
      t.attachment :picture
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
