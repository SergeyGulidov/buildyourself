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

ActiveRecord::Schema.define(:version => 20130410182817) do

  create_table "brains", :force => true do |t|
  end

  create_table "categories", :force => true do |t|
    t.string "category_name_ru"
    t.string "category_slug"
    t.string "category_name_lv"
  end

  add_index "categories", ["category_slug"], :name => "index_categories_on_category_slug"

  create_table "categorizations", :id => false, :force => true do |t|
    t.integer "type_id"
    t.integer "category_id"
    t.integer "place_id"
    t.integer "interval_id"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["interval_id"], :name => "index_categorizations_on_interval_id"
  add_index "categorizations", ["place_id"], :name => "index_categorizations_on_place_id"
  add_index "categorizations", ["type_id"], :name => "index_categorizations_on_type_id"

  create_table "cities", :force => true do |t|
    t.string "city_name_lv"
    t.string "city_name_ru"
    t.string "city_slug"
  end

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.text     "body"
    t.datetime "created_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string "country_name_lv"
    t.string "country_name_ru"
    t.string "country_slug"
  end

  create_table "intervals", :force => true do |t|
    t.string "interval_name_ru"
    t.string "interval_slug"
    t.string "interval_name_lv"
  end

  add_index "intervals", ["interval_slug"], :name => "index_intervals_on_interval_slug"

  create_table "photos", :force => true do |t|
    t.integer "place_id"
    t.string  "name"
    t.string  "photo"
  end

  create_table "place_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "value"
    t.integer "place_id", :default => 0
  end

  add_index "place_votes", ["user_id"], :name => "index_place_votes_on_user_id"

  create_table "places", :force => true do |t|
    t.string   "street"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.string   "name"
    t.text     "message_ru"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "user_id"
    t.integer  "approved",    :default => 0
    t.text     "message_lv"
    t.text     "review_ru"
    t.text     "review_lv"
    t.integer  "with_review", :default => 0
    t.integer  "sponsor",     :default => 0
    t.integer  "vip",         :default => 0
    t.text     "comment"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "hits",        :default => 0
  end

  create_table "types", :force => true do |t|
    t.string "type_name_ru"
    t.string "type_slug"
    t.string "type_name_lv"
  end

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
