class CreateSends < ActiveRecord::Migration
  def change
    create_table :sends do |t|
      t.string :title
      t.text :content
      t.string :tag
      t.boolean :del

      t.timestamps
    end
  end
end
