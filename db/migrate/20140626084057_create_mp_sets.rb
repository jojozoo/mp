class CreateMpSets < ActiveRecord::Migration
  def change
    create_table :mp_sets do |t|
      t.string :title
      t.string :link
      t.string :src
      t.integer :cate
      t.integer :cate_id
      t.integer :user_id
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
