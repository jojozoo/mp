class CreateDes < ActiveRecord::Migration
  def change
    create_table :des do |t|
      t.integer :source_id
      t.string :source_type
      t.integer :image_id
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
