class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.references :sourcer, polymorphic: true
      t.string :type
      t.integer :user_id
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
