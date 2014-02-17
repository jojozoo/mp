class CreatePutins < ActiveRecord::Migration
  def change
    create_table :putins do |t|
      t.integer :ad_id
      t.integer :click, default: 0
      t.integer :browser, default: 0
      t.string :from, default: 'mp'
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :state, default: false
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
