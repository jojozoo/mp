class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.attachment :logo
      t.integer :user_id
      t.string :name
      t.string :desc
      t.boolean :publish, default: true
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
