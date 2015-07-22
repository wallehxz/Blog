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

ActiveRecord::Schema.define(:version => 20151123019527) do

  create_table "admins", :force => true do |t|
    t.string   "account"
    t.string   "password"
    t.string   "email"
    t.string   "phone"
    t.string   "nickname"
    t.string   "birthday"
    t.string   "login_ip"
    t.integer  "login_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "embarrass_comments", :force => true do |t|
    t.integer  "embarrass_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "embarrass_comments", ["embarrass_id"], :name => "index_embarrass_comments_on_embarrass_id"
  add_index "embarrass_comments", ["user_id"], :name => "index_embarrass_comments_on_user_id"

  create_table "embarrasses", :force => true do |t|
    t.integer  "user_id"
    t.text     "process"
    t.string   "picture"
    t.integer  "chan_count", :default => 1
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "embarrasses", ["user_id"], :name => "index_embarrasses_on_user_id"

  create_table "game_comments", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "game_comments", ["game_id"], :name => "index_game_comments_on_game_id"
  add_index "game_comments", ["user_id"], :name => "index_game_comments_on_user_id"

  create_table "game_lives", :force => true do |t|
    t.string   "live_title"
    t.string   "live_url"
    t.string   "live_type"
    t.string   "live_interval"
    t.string   "person_name"
    t.text     "person_resume"
    t.integer  "attention",     :default => 1
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "person_cover"
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.string   "note_title"
    t.date     "note_date"
    t.string   "note_weather"
    t.string   "note_tag"
    t.text     "note_content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "notes", ["user_id"], :name => "index_notes_on_user_id"

  create_table "relax_comments", :force => true do |t|
    t.integer  "relax_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "relax_comments", ["relax_id"], :name => "index_relax_comments_on_relax_id"
  add_index "relax_comments", ["user_id"], :name => "index_relax_comments_on_user_id"

  create_table "relax_moments", :force => true do |t|
    t.string   "relax_title"
    t.date     "relax_time"
    t.string   "relax_audio"
    t.text     "relax_content"
    t.integer  "chan_count",    :default => 1
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "topic_comments", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topic_comments", ["topic_id"], :name => "index_topic_comments_on_topic_id"
  add_index "topic_comments", ["user_id"], :name => "index_topic_comments_on_user_id"

  create_table "topics", :force => true do |t|
    t.integer  "user_id"
    t.string   "topic_title"
    t.string   "topic_type"
    t.text     "topic_content"
    t.string   "topic_tag"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "topics", ["user_id"], :name => "index_topics_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "account"
    t.string   "password"
    t.string   "phone"
    t.string   "verify_code"
    t.datetime "verify_time"
    t.string   "signature"
    t.string   "avatar"
    t.string   "nickname"
    t.date     "birthday"
    t.string   "hobby"
    t.string   "constellation"
    t.string   "educational"
    t.string   "full_name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "login_times"
    t.string   "login_ip"
    t.string   "qq"
    t.string   "weixin"
    t.string   "email"
    t.string   "weibo"
    t.string   "yy"
    t.string   "company"
    t.string   "office"
    t.string   "inauguration_time"
    t.string   "colleges"
    t.string   "discipline"
    t.string   "school_time"
    t.integer  "integration"
    t.string   "project_name1"
    t.string   "project_url1"
    t.string   "project_name2"
    t.string   "project_url2"
    t.string   "project_name3"
    t.string   "project_url3"
    t.string   "project_name4"
    t.string   "project_url4"
  end

  add_index "users", ["id"], :name => "index_users_on_id"

end
