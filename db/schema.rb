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

ActiveRecord::Schema.define(:version => 20140510111440) do

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
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.string   "desc"
    t.boolean  "publish",           :default => true
    t.boolean  "del",               :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "banners", :force => true do |t|
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "link",                 :default => "javascript:void(0);"
    t.string   "title"
    t.string   "desc"
    t.boolean  "del",                  :default => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.integer  "user_id"
    t.integer  "reply_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "editors", :force => true do |t|
    t.integer  "event_id"
    t.integer  "editor_id"
    t.integer  "sum"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.text     "desc"
    t.string   "channel"
    t.date     "end_time"
    t.integer  "members_count",     :default => 0
    t.integer  "photos_count",      :default => 0
    t.integer  "state",             :default => 0
    t.boolean  "request",           :default => false
    t.datetime "request_at"
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

  create_table "folships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "fol_id"
    t.string   "mark"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "mail_invites", :force => true do |t|
    t.string   "uid"
    t.string   "email"
    t.string   "username"
    t.boolean  "isview"
    t.integer  "isclick"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "user_id"
    t.string   "talk"
    t.integer  "state",      :default => 0
    t.integer  "s_is_del",   :default => 0
    t.integer  "u_is_del",   :default => 0
    t.string   "content"
    t.integer  "del",        :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "notices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "send_id"
    t.string   "title"
    t.text     "content"
    t.boolean  "read"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "work_id"
    t.integer  "album_id"
    t.integer  "groupid"
    t.boolean  "state",                :default => false
    t.boolean  "editor",               :default => false
    t.integer  "score",                :default => 0
    t.integer  "recs_count",           :default => 0
    t.integer  "liks_count",           :default => 0
    t.integer  "stos_count",           :default => 0
    t.integer  "vist_count",           :default => 0
    t.integer  "coms_count",           :default => 0
    t.boolean  "recommend",            :default => false
    t.datetime "recommend_at"
    t.boolean  "choice",               :default => false
    t.datetime "choice_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "name"
    t.string   "title"
    t.string   "desc"
    t.integer  "warrant"
    t.string   "randomhex"
    t.string   "randomstr"
    t.text     "exif"
    t.string   "wh"
    t.boolean  "del",                  :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "channel"
    t.integer  "sum",        :default => 0
    t.string   "desc"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tagships", :force => true do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.string   "name"
    t.string   "channel"
    t.integer  "tag_id"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "owner_id"
    t.integer  "last_user_id"
    t.datetime "last_updated_at"
    t.boolean  "emphasis",        :default => false
    t.datetime "emphasis_at"
    t.string   "title"
    t.string   "content"
    t.integer  "comments_count",  :default => 0
    t.boolean  "del",             :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "tuis", :force => true do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.integer  "source_id"
    t.string   "source_type"
    t.string   "channel"
    t.integer  "user_id"
    t.integer  "editor"
    t.integer  "editor_id"
    t.string   "mark"
    t.boolean  "del",         :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "email"
    t.string   "username"
    t.string   "nickname"
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
    t.integer  "warrant",             :default => 5
    t.boolean  "admin",               :default => false
    t.boolean  "photographer",        :default => false
    t.integer  "nots_count",          :default => 0
    t.integer  "fols_count",          :default => 0
    t.integer  "msgs_count",          :default => 0
    t.integer  "phos_count",          :default => 0
    t.integer  "albs_count",          :default => 0
    t.integer  "wors_count",          :default => 0
    t.integer  "liks_count",          :default => 0
    t.integer  "stos_count",          :default => 0
    t.boolean  "del",                 :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "visits", :force => true do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.integer  "user_id"
    t.string   "mark"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "works", :force => true do |t|
    t.integer  "user_id"
    t.integer  "cover_id"
    t.integer  "photos_count",   :default => 0
    t.integer  "comments_count", :default => 0
    t.integer  "visit_count",    :default => 0
    t.string   "title"
    t.string   "desc"
    t.boolean  "del",            :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

end
