class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :nickname
      t.string :mobile
      t.string :email
      t.string :province
      t.string :city
      t.string :remember_me
      t.string :salt
      t.string :resume
      t.string :domain
      t.string :profession # 职业
      t.date   :duty
      t.boolean :gender
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
