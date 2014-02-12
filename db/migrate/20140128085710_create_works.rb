class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :image_id
      t.integer :event_id
      t.integer :warrant
      t.integer :winner
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
