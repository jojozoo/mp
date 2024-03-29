class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :nickname
      t.string :realname
      t.string :mobile
      t.string :password
      t.string :salt
      t.attachment :avatar
      t.string :province
      t.string :city
      t.string :site
      t.string :resume
      t.string :domain
      t.string :profession # 职业
      t.date   :duty
      t.boolean :gender
      t.integer :warrant, default: 5 # 授权
      t.boolean :admin, default: 0 # 管理员
      t.boolean :photographer, default: 0 # 摄影师
      t.integer :notices_count, default: 0
      t.integer :followers_count, default: 0 # 关注者数量
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
