class CreateSends < ActiveRecord::Migration
  def change
    create_table :sends do |t|
      t.string :title
      t.text :content
      t.string :channel
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
