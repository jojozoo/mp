class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id
      t.attachment :picture
      t.string :name
      t.string :exif
      t.boolean :del, default: false
      # +----------------------+--------------+------+-----+---------+----------------+
      # | Field                | Type         | Null | Key | Default | Extra          |
      # +----------------------+--------------+------+-----+---------+----------------+
      # | id                   | int(11)      | NO   | PRI | NULL    | auto_increment |
      # | user_id              | int(11)      | YES  |     | NULL    |                |
      # | picture_file_name    | varchar(255) | YES  |     | NULL    |                |
      # | picture_content_type | varchar(255) | YES  |     | NULL    |                |
      # | picture_file_size    | int(11)      | YES  |     | NULL    |                |
      # | picture_updated_at   | datetime     | YES  |     | NULL    |                |
      # | name                 | varchar(255) | YES  |     | NULL    |                |
      # | exif                 | varchar(255) | YES  |     | NULL    |                |
      # | created_at           | datetime     | NO   |     | NULL    |                |
      # | updated_at           | datetime     | NO   |     | NULL    |                |
      # +----------------------+--------------+------+-----+---------+----------------+
      t.timestamps
    end
  end
end
