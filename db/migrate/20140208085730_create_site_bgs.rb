class CreateSiteBgs < ActiveRecord::Migration
  def change
    create_table :site_bgs do |t|
      t.attachment :photo
      t.string :link
      t.string :title
      t.string :desc
      t.string :type # 什么类型 banner 还是 background 还是 sign
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
