class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :t
      t.integer :likes_count, default: 0
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
