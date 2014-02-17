class CreateSbanners < ActiveRecord::Migration
  def change
    create_table :sbanners do |t|
      t.attachment :photo
      t.string :link, default: 'javascript:void(0);'
      t.string :title
      t.string :desc
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
