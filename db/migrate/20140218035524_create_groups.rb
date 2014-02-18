class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.integer :publish, default: true
      t.integer :topics_count, default: 0
      t.integer :members_count, default: 0
      t.integer :visits_count, default: 0
      t.string :title
      t.text :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
