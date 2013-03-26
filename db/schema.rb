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

ActiveRecord::Schema.define(:version => 20130326184138) do

  create_table "assignments", :force => true do |t|
    t.integer "place_id"
    t.integer "type_id"
  end

  add_index "assignments", ["place_id"], :name => "index_assignments_on_place_id"
  add_index "assignments", ["type_id"], :name => "index_assignments_on_type_id"

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.text     "body"
    t.datetime "created_at", :null => false
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
    t.boolean  "manytypes"
    t.text     "message"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "different_type"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
    t.integer  "approved",       :default => 0
    t.integer  "user_id"
    t.string   "city"
  end

  create_table "roles", :force => true do |t|
    t.string  "name"
    t.integer "user_id"
  end

  create_table "type_translations", :force => true do |t|
    t.integer "type_id"
    t.string  "locale"
    t.string  "title"
    t.string  "category"
  end

  add_index "type_translations", ["locale"], :name => "index_type_translations_on_locale"
  add_index "type_translations", ["type_id"], :name => "index_type_translations_on_type_id"

  create_table "types", :force => true do |t|
    t.string "title"
    t.string "category"
    t.string "slug"
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
