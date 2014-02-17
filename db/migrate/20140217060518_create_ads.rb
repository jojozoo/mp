class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.attachment :photo
      t.string :title
      t.string :desc
      t.string :target
      t.integer :t
      t.integer :s
      t.integer :b, default: 0
      t.integer :c, default: 0
      t.string :f
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
