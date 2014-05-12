class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.integer :event_id
      t.integer :editor_id
      t.integer :sum
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
