class CreateBgs < ActiveRecord::Migration
  def change
    create_table :bgs do |t|
      t.attachment :name
      t.string :repeat
      t.integer :user_id

      t.timestamps
    end
  end
end
