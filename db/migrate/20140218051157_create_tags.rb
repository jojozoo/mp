class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :pinyin
      t.string :channel
      t.string :cate
      t.integer :sum, default: 0
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
