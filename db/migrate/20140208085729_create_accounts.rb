class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :uid
      t.integer :user_id
      t.string :site
      t.string :token
      t.string :refresh_token
      t.string :expires_in
      t.string :expires_at
      t.text :other

      t.timestamps
    end
  end
end
