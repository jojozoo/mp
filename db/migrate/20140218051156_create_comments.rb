class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :obj, polymorphic: true
      t.integer :user_id
      t.integer :reply_id
      t.string :title
      t.text :content
      t.boolean :del, default: false

      t.timestamps
    end
    # add_index :comments, :obj_id
  end
end
