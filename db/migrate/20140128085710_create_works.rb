class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :cover_id
      t.integer :event_id
      t.integer :warrant
      t.integer :winner
      t.string :title
      t.string :desc
      t.integer :images_count, default: 0
      t.integer :comments_count, default: 0
      t.integer :visits_count, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
