class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :name
      t.attachment :logo
      t.string :text
      t.integer :open, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
