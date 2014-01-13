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
      t.string :province
      t.string :city
      t.string :site
      t.string :resume
      t.string :domain
      t.string :profession # 职业
      t.date   :duty
      t.boolean :gender
      t.integer :warrant # 授权
      t.string :bg, default: 'body01.jpg'
      t.string :bg_repeat, default: 'repeat'
      t.string :remember_me
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
