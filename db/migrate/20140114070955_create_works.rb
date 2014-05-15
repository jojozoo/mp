class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :cover_id
      t.integer :photos_count,   default: 0
      t.integer :coms_count, default: 0
      t.integer :visit_count,    default: 0
      t.string :title
      t.string :desc
      t.boolean :del,            default: false

      t.timestamps
    end
  end
end
