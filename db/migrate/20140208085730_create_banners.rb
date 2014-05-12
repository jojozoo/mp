class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.attachment :picture
      t.string :link, default: 'javascript:void(0);'
      t.string :title
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
