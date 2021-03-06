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

ActiveRecord::Schema.define(:version => 20130630082021) do

  create_table "attachments", :force => true do |t|
    t.string  "file"
    t.integer "request_id"
  end

  create_table "brains", :force => true do |t|
  end

  create_table "byways", :force => true do |t|
    t.string  "street"
    t.integer "place_id"
    t.integer "city_id"
    t.integer "country_id"
    t.float   "latitude"
    t.float   "longitude"
    t.boolean "gmaps"
    t.integer "user_id",    :default => 1
  end

  create_table "categories", :force => true do |t|
    t.string  "category_name_ru"
    t.string  "category_slug"
    t.string  "category_name_lv"
    t.integer "places_count",     :default => 0
  end

  add_index "categories", ["category_slug"], :name => "index_categories_on_category_slug"

  create_table "cities", :force => true do |t|
    t.string  "city_name_lv"
    t.string  "city_name_ru"
    t.string  "city_slug"
    t.integer "places_count", :default => 0
  end

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.text     "body"
    t.datetime "created_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string  "country_name_lv"
    t.string  "country_name_ru"
    t.string  "country_slug"
    t.integer "places_count",    :default => 0
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "feeds", :force => true do |t|
    t.string   "message"
    t.integer  "place_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "user_id",    :default => 1
  end

  add_index "feeds", ["place_id"], :name => "index_feeds_on_place_id"

  create_table "photos", :force => true do |t|
    t.integer "place_id"
    t.string  "photo"
    t.integer "request_id"
  end

  create_table "place_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "value"
    t.integer "place_id", :default => 0
  end

  add_index "place_votes", ["user_id"], :name => "index_place_votes_on_user_id"

  create_table "places", :force => true do |t|
    t.string   "street"
    t.string   "name"
    t.text     "message_ru"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "user_id"
    t.integer  "approved",     :default => 0
    t.text     "message_lv"
    t.integer  "vip",          :default => 0
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "hits",         :default => 0
    t.integer  "translated",   :default => 0
    t.float    "month_price"
    t.integer  "age_min"
    t.integer  "age_max"
    t.integer  "not_actual",   :default => 0
    t.integer  "category_id",  :default => 1
    t.integer  "type_id",      :default => 1
    t.string   "slug"
    t.integer  "ru",           :default => 0
    t.integer  "lv",           :default => 0
    t.integer  "simple_place", :default => 1
    t.integer  "phone"
    t.string   "email"
    t.string   "website"
  end

  add_index "places", ["age_max"], :name => "index_places_on_age_max"
  add_index "places", ["age_min"], :name => "index_places_on_age_min"
  add_index "places", ["category_id"], :name => "index_places_on_category_id"
  add_index "places", ["slug"], :name => "index_places_on_slug"
  add_index "places", ["type_id"], :name => "index_places_on_type_id"

  create_table "posts", :force => true do |t|
    t.string   "title_ru"
    t.string   "title_lv"
    t.text     "message_lv"
    t.text     "message_ru"
    t.string   "image"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "hits",       :default => 0
    t.integer  "user_id"
    t.string   "file"
    t.integer  "approved",   :default => 0
    t.integer  "ru",         :default => 0
    t.integer  "lv",         :default => 0
  end

  add_index "posts", ["id"], :name => "index_posts_on_id"

  create_table "requests", :force => true do |t|
    t.string   "phone"
    t.string   "address"
    t.string   "when"
    t.datetime "created_at",   :null => false
    t.text     "message"
    t.string   "email"
    t.string   "source_1"
    t.string   "source_2"
    t.string   "source_3"
    t.string   "source_4"
    t.integer  "simple_place"
    t.string   "website"
    t.integer  "age_max"
    t.integer  "age_min"
  end

  create_table "schedules", :force => true do |t|
    t.string   "mon"
    t.string   "tue"
    t.string   "wed"
    t.string   "thu"
    t.string   "fri"
    t.string   "sat"
    t.string   "sun"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
    t.integer  "place_id"
    t.string   "group",      :default => "1"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.integer  "confirmed",     :default => 0
    t.string   "confirm_token"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "lang",          :default => "lv"
  end

  add_index "subscribers", ["user_id"], :name => "index_subscribers_on_user_id"

  create_table "types", :force => true do |t|
    t.string  "type_name_ru"
    t.string  "type_slug"
    t.string  "type_name_lv"
    t.integer "category_id",  :default => 1
    t.integer "places_count", :default => 0
  end

  add_index "types", ["category_id"], :name => "index_types_on_category_id"
  add_index "types", ["type_slug"], :name => "index_types_on_type_slug"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "role",                   :default => 2
    t.string   "provider"
    t.string   "uid"
    t.integer  "failed_attempts",        :default => 0
    t.datetime "locked_at"
    t.string   "avatar"
    t.text     "about_ru"
    t.text     "about_lv"
    t.string   "web_site"
    t.string   "phone"
    t.string   "name"
    t.integer  "sponsor",                :default => 0
    t.integer  "comments",               :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
