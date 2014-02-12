class CreateMicros < ActiveRecord::Migration
  def change
    create_table :micros do |t|
      t.integer :user_id
      t.string :name
      t.string :title
      t.string :text
      t.references :source, polymorphic: true
      t.string :source_name
      t.string :source_title
      t.string :source_text
      t.references :sourcer, polymorphic: true
      t.string :sourcer_name
      t.string :sourcer_title
      t.string :sourcer_text
      t.references :refer, polymorphic: true
      t.string :refer_name
      t.string :refer_title
      t.string :refer_text
      t.references :referer, polymorphic: true
      t.string :referer_name
      t.string :referer_title
      t.string :referer_text
      t.references :extra, polymorphic: true
      t.string :extra_name
      t.string :extra_title
      t.string :extra_text
      t.references :extraer, polymorphic: true
      t.string :extraer_name
      t.string :extraer_title
      t.string :extraer_text
      t.boolean :del, default: false

      t.timestamps
    end
  end
end
