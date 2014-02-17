class CreateSends < ActiveRecord::Migration
  def change
    create_table :sends do |t|
      t.string :title
      t.text :content
      t.string :tag
      t.string :target
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
