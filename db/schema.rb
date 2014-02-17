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

ActiveRecord::Schema.define(:version => 20140208085730) do

  create_table "accounts", :force => true do |t|
    t.string   "uid"
    t.integer  "user_id"
    t.string   "site"
    t.string   "name"
    t.string   "token"
    t.string   "refresh_token"
    t.string   "expires_in"
    t.string   "expires_at"
    t.text     "other"
    t.boolean  "del",           :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "desc"
    t.integer  "open",              :default => 0
    t.boolean  "del",               :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "title"
    t.text     "desc"
    t.string   "tag"
    t.date     "end_time"
    t.integer  "members_count",     :default => 0
    t.integer  "works_count",       :default => 0
    t.integer  "state",             :default => 0
    t.boolean  "show",              :default => false
    t.boolean  "del",               :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.integer  "ip"
    t.text     "desc"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "album_id"
    t.integer  "event_id"
    t.integer  "state",                :default => 0
    t.integer  "warrant"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "desc"
    t.text     "exif"
    t.boolean  "del",                  :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "talk_id"
    t.integer  "user_id"
    t.string   "content"
    t.integer  "del",        :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "micros", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "title"
    t.string   "text"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "source_name"
    t.string   "source_title"
    t.string   "source_text"
    t.integer  "sourcer_id"
    t.string   "sourcer_type"
    t.string   "sourcer_name"
    t.string   "sourcer_title"
    t.string   "sourcer_text"
    t.integer  "refer_id"
    t.string   "refer_type"
    t.string   "refer_name"
    t.string   "refer_title"
    t.string   "refer_text"
    t.integer  "referer_id"
    t.string   "referer_type"
    t.string   "referer_name"
    t.string   "referer_title"
    t.string   "referer_text"
    t.integer  "extra_id"
    t.string   "extra_type"
    t.string   "extra_name"
    t.string   "extra_title"
    t.string   "extra_text"
    t.integer  "extraer_id"
    t.string   "extraer_type"
    t.string   "extraer_name"
    t.string   "extraer_title"
    t.string   "extraer_text"
    t.boolean  "del",           :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "notices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sends_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "read"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "pushes", :force => true do |t|
    t.integer  "sourcer_id"
    t.string   "sourcer_type"
    t.string   "type"
    t.integer  "user_id"
    t.boolean  "del",          :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "sends", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "tag"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "site_bgs", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "link"
    t.string   "title"
    t.string   "desc"
    t.string   "type"
    t.boolean  "del",                :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
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
    t.string   "content"
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
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "province"
    t.string   "city"
    t.string   "site"
    t.string   "resume"
    t.string   "domain"
    t.string   "profession"
    t.date     "duty"
    t.boolean  "gender"
    t.integer  "warrant"
    t.boolean  "admin",               :default => false
    t.boolean  "photographer",        :default => false
    t.integer  "talks_count",         :default => 0
    t.integer  "notices_count",       :default => 0
    t.string   "bg",                  :default => "/images/defaults/bg.jpg"
    t.string   "repeat",              :default => "repeat"
    t.string   "remember_me"
    t.boolean  "del",                 :default => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "works", :force => true do |t|
    t.integer  "user_id"
    t.integer  "image_id"
    t.integer  "event_id"
    t.integer  "warrant"
    t.integer  "winner"
    t.string   "desc"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

end
