class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.references :sourcer, polymorphic: true
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
