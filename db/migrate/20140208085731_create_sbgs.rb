class CreateSbgs < ActiveRecord::Migration
  def change
    create_table :sbgs do |t|
      t.attachment :photo
      t.boolean :bg, default: true
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
