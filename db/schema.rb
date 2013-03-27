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

ActiveRecord::Schema.define(:version => 20130327162653) do

  create_table "assignments", :id => false, :force => true do |t|
    t.integer "place_id"
    t.integer "type_id"
  end

  add_index "assignments", ["place_id"], :name => "index_assignments_on_place_id"
  add_index "assignments", ["type_id"], :name => "index_assignments_on_type_id"

  create_table "categories", :force => true do |t|
    t.string "category_name"
    t.string "category_slug"
  end

  create_table "categorizations", :id => false, :force => true do |t|
    t.integer "type_id"
    t.integer "category_id"
    t.integer "place_id"
    t.integer "interval_id"
  end

  add_index "categorizations", ["category_id"], :name => "index_categorizations_on_category_id"
  add_index "categorizations", ["place_id"], :name => "index_categorizations_on_place_id"
  add_index "categorizations", ["type_id"], :name => "index_categorizations_on_type_id"

  create_table "category_translations", :force => true do |t|
    t.integer "category_id"
    t.string  "locale"
    t.string  "category_name"
  end

  add_index "category_translations", ["category_id"], :name => "index_category_translations_on_category_id"
  add_index "category_translations", ["locale"], :name => "index_category_translations_on_locale"

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.text     "body"
    t.datetime "created_at", :null => false
  end

  create_table "interval_translations", :force => true do |t|
    t.integer  "interval_id"
    t.string   "locale"
    t.string   "interval_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "interval_translations", ["interval_id"], :name => "index_interval_translations_on_interval_id"
  add_index "interval_translations", ["locale"], :name => "index_interval_translations_on_locale"

  create_table "intervals", :force => true do |t|
    t.string "interval_name"
    t.string "interval_slug"
  end

  create_table "photos", :force => true do |t|
    t.integer "place_id"
    t.string  "name"
    t.string  "photo"
  end

  create_table "place_translations", :force => true do |t|
    t.integer "place_id"
    t.string  "locale"
    t.text    "message"
    t.string  "city"
  end

  add_index "place_translations", ["locale"], :name => "index_place_translations_on_locale"
  add_index "place_translations", ["place_id"], :name => "index_place_translations_on_place_id"

  create_table "place_votes", :force => true do |t|
    t.integer "user_id"
    t.integer "value"
    t.string  "place_id"
  end

  add_index "place_votes", ["user_id"], :name => "index_place_votes_on_user_id"

  create_table "places", :force => true do |t|
    t.string   "country"
    t.string   "street"
    t.string   "phone"
    t.string   "website"
    t.string   "email"
    t.string   "name"
    t.text     "message"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "user_id"
    t.string   "city"
    t.integer  "manytypes"
    t.integer  "approved",   :default => 0
  end

  create_table "places_category", :force => true do |t|
    t.integer "place_id"
    t.integer "category_id"
  end

  add_index "places_category", ["category_id"], :name => "index_places_category_on_category_id"
  add_index "places_category", ["place_id"], :name => "index_places_category_on_place_id"

  create_table "roles", :force => true do |t|
    t.string  "name"
    t.integer "user_id"
  end

  create_table "type_translations", :force => true do |t|
    t.integer "type_id"
    t.string  "locale"
    t.string  "title"
  end

  add_index "type_translations", ["locale"], :name => "index_type_translations_on_locale"
  add_index "type_translations", ["type_id"], :name => "index_type_translations_on_type_id"

  create_table "types", :force => true do |t|
    t.string "title"
    t.string "type_slug"
  end

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
