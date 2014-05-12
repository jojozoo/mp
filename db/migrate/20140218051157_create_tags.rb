class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :channel
      t.integer :sum, default: 0
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
