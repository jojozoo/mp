class CreateTuis < ActiveRecord::Migration
  def change
    create_table :tuis do |t|
      t.references :obj, polymorphic: true
      t.string :type
      t.integer :user_id
      t.integer :score, default: 0
      t.string :mark
      t.boolean :del, default: false

      t.timestamps
    end
    # add_index :tuis, :obj_id
  end
end
