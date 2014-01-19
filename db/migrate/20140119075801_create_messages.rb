class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :state, default: 0
      t.boolean :fdel, default: 0
      t.boolean :sdel, default: 0
      t.string :content

      t.timestamps
    end
  end
end
