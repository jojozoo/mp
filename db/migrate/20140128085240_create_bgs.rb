class CreateBgs < ActiveRecord::Migration
  def change
    create_table :bgs do |t|
      t.attachment :name
      t.string :repeat
      t.integer :user_id
      t.boolean :admin, default: false
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
