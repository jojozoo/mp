class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :obj, polymorphic: true
      t.integer :user_id
      t.string :mark
      t.boolean :del, default: false

      t.timestamps
    end
    # add_index :visits, :obj_id
  end
end
