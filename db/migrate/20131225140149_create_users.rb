class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :nickname
      t.string :realname
      t.string :mobile
      t.string :encrypted_password
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
      t.integer :warrant # 授权
      t.integer :talks_count, default: 0
      t.integer :notices_count, default: 0
      t.string :bg, default: '/images/defaults/bg.jpg'
      t.string :repeat, default: 'repeat'
      t.string :remember_me
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
