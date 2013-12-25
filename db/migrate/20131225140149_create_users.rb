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

      t.timestamps
    end
  end
end
