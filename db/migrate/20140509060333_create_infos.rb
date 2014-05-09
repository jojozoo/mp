class CreateInfos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.string :url
      t.string :site
      t.string :path
      t.string :nickname
      t.string :local
      t.string :email
      t.string :gender
      t.string :domain
      t.string :desc
      t.string :func
      t.string :tag
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
