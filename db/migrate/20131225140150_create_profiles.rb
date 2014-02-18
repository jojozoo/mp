class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :pmail
      t.string :psite
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
