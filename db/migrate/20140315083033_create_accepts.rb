class CreateAccepts < ActiveRecord::Migration
  def change
    create_table :accepts do |t|
      t.integer :user_id
      t.boolean :followd_mail,   default: false
      t.boolean :recom_mail,     default: false
      t.boolean :laud_mail,      default: false
      t.boolean :like_mail,      default: false
      t.boolean :store_mail,     default: false
      t.boolean :comment_mail,   default: false
      t.boolean :msg_mail,       default: false
      t.boolean :followd_notice, default: false
      t.boolean :recom_notice,   default: false
      t.boolean :laud_notice,    default: false
      t.boolean :like_notice,    default: false
      t.boolean :store_notice,   default: false
      t.boolean :comment_notice, default: false
      t.boolean :msg_notice,     default: false
      
      t.boolean :del,            default: false

      t.timestamps
    end
  end
end
