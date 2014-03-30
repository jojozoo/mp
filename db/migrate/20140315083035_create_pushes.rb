class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.references :obj, polymorphic: true
      t.references :source, polymorphic: true
      t.string :channel
      t.integer :user_id
      t.string :mark
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
