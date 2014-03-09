class CreateObjTags < ActiveRecord::Migration
  def change
    create_table :obj_tags do |t|
      t.references :obj, polymorphic: true
      t.integer :tag_id
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
