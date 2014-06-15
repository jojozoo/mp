class CreateEmphases < ActiveRecord::Migration
  def change
    create_table :emphases do |t|
      t.string :title
      t.string :link
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
