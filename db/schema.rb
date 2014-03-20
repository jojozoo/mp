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

ActiveRecord::Schema.define(:version => 20140315083034) do

  create_table "accepts", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "followd_mail",   :default => false
    t.boolean  "recom_mail",     :default => false
    t.boolean  "laud_mail",      :default => false
    t.boolean  "like_mail",      :default => false
    t.boolean  "store_mail",     :default => false
    t.boolean  "comment_mail",   :default => false
    t.boolean  "msg_mail",       :default => false
    t.boolean  "followd_notice", :default => false
    t.boolean  "recom_notice",   :default => false
    t.boolean  "laud_notice",    :default => false
    t.boolean  "like_notice",    :default => false
    t.boolean  "store_notice",   :default => false
    t.boolean  "comment_notice", :default => false
    t.boolean  "msg_notice",     :default => false
    t.boolean  "del",            :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

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

  create_table "ads", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "title"
    t.string   "desc"
    t.string   "target"
    t.integer  "t"
    t.integer  "s"
    t.boolean  "del",                :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
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

  create_table "events", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "title"
    t.text     "desc"
    t.string   "channel"
    t.date     "end_time"
    t.integer  "members_count",     :default => 0
    t.integer  "works_count",       :default => 0
    t.integer  "state",             :default => 0
    t.boolean  "totop",             :default => false
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

  create_table "follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.string   "mark"
    t.boolean  "del",         :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "work_id"
    t.integer  "album_id"
    t.integer  "state",                :default => 0
    t.integer  "lauds_count",          :default => 0
    t.integer  "likes_count",          :default => 0
    t.integer  "stores_count",         :default => 0
    t.integer  "recoms_count",         :default => 0
    t.integer  "comments_count",       :default => 0
    t.integer  "warrant"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "hex"
    t.string   "desc"
    t.text     "exif"
    t.string   "wh"
    t.boolean  "del",                  :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
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

  create_table "obj_tags", :force => true do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.integer  "tag_id"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "pmail"
    t.string   "psite"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "pushes", :force => true do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.string   "type"
    t.integer  "user_id"
    t.string   "mark"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "putins", :force => true do |t|
    t.integer  "ad_id"
    t.integer  "click",      :default => 0
    t.integer  "browser",    :default => 0
    t.string   "from",       :default => "mp"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "state",      :default => false
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "sbanners", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "link",               :default => "javascript:void(0);"
    t.string   "title"
    t.string   "desc"
    t.boolean  "del",                :default => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  create_table "sbgs", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "bg",                 :default => true
    t.boolean  "del",                :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "sends", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "channel"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "channel"
    t.integer  "objs_count", :default => 0
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "last_user_id"
    t.datetime "last_updated_at"
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
    t.string   "type"
    t.integer  "user_id"
    t.integer  "score",      :default => 0
    t.string   "mark"
    t.boolean  "del",        :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
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
    t.integer  "warrant",             :default => 5
    t.boolean  "admin",               :default => false
    t.boolean  "photographer",        :default => false
    t.integer  "notices_count",       :default => 0
    t.integer  "followers_count",     :default => 0
    t.string   "bg",                  :default => "/images/defaults/bgs.jpg"
    t.string   "repeat",              :default => "repeat"
    t.string   "remember_me"
    t.boolean  "del",                 :default => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
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
    t.integer  "event_id"
    t.integer  "warrant"
    t.integer  "winner"
    t.string   "title"
    t.string   "desc"
    t.integer  "images_count", :default => 0
    t.boolean  "del",          :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

end
