class CreateTps < ActiveRecord::Migration
  def change
    create_table :tps do |t|
      t.integer    :user_id
      t.attachment :picture
      t.text       :exif
      t.string     :randomstr
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
