class CreateColls < ActiveRecord::Migration
  def change
    create_table :colls do |t|
      t.integer :user_id
      t.string :title
      t.string :desc
      t.integer :state, default: 1
      t.boolean :publish, default: false
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
