class CreateMailInvites < ActiveRecord::Migration
  # 用于邀请统计 邮件邀请之类的
  def change
    create_table :mail_invites do |t| 
      t.string  :uid
      t.string  :email
      t.string  :username      
      t.boolean :isview  # 
      t.integer :isclick #
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
