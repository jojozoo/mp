class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :name
      t.attachment :logo
      t.string :desc
      t.integer :open
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
