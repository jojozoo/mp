class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :winner, default: 0
      t.integer :level

      t.timestamps
    end
  end
end
