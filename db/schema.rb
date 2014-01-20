# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140120145855) do

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "desc"
    t.integer  "open"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "des", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "image_id"
    t.integer  "user_id"
    t.string   "desc"
    t.boolean  "del",         :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "logo_id"
    t.string   "title"
    t.text     "content"
    t.string   "tag"
    t.date     "end_time"
    t.integer  "partners_count", :default => 0
    t.integer  "images_count",   :default => 0
    t.integer  "state",          :default => 0
    t.boolean  "show",           :default => false
    t.boolean  "del",            :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "album_id"
    t.integer  "state",                :default => 0
    t.integer  "warrant"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.text     "picture_meta"
    t.string   "exif"
    t.boolean  "del",                  :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "talk_id"
    t.integer  "user_id"
    t.string   "text"
    t.integer  "del",        :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "notices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sends_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "read"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "partners", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "winner",     :default => false
    t.integer  "level"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "sends", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "tag"
    t.boolean  "del"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "t"
    t.integer  "likes_count", :default => 0
    t.boolean  "del",         :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "talks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.string   "text"
    t.integer  "state",          :default => 1
    t.integer  "messages_count", :default => 0
    t.boolean  "del",            :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "nickname"
    t.string   "realname"
    t.string   "mobile"
    t.string   "password"
    t.string   "salt"
    t.string   "province"
    t.string   "city"
    t.string   "site"
    t.string   "resume"
    t.string   "domain"
    t.string   "profession"
    t.date     "duty"
    t.boolean  "gender"
    t.integer  "warrant"
    t.integer  "talks_count",   :default => 0
    t.integer  "notices_count", :default => 0
    t.string   "bg",            :default => "body01.jpg"
    t.string   "bg_repeat",     :default => "repeat"
    t.string   "remember_me"
    t.boolean  "del",           :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

end
