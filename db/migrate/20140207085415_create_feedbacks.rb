class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.string :subject
      t.integer :ip
      t.text :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
