class CreateFolships < ActiveRecord::Migration
  def change
    create_table :folships do |t|
      t.integer :user_id
      t.integer :fol_id
      t.string :mark
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
