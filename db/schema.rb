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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131012142109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "devices", force: true do |t|
    t.string   "token"
    t.string   "push_token"
    t.string   "operating_system"
    t.string   "app_version"
    t.datetime "last_request_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.text     "description"
    t.integer  "local_id"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "short_description"
  end

  add_index "events", ["local_id"], name: "index_events_on_local_id", using: :btree

  create_table "local_contents", force: true do |t|
    t.string   "name"
    t.integer  "local_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description", default: ""
    t.boolean  "confirmed"
  end

  add_index "local_contents", ["local_id"], name: "index_local_contents_on_local_id", using: :btree

  create_table "locals", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "poi"
  end

  add_index "locals", ["user_id"], name: "index_locals_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "local_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["local_id"], name: "index_taggings_on_local_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.text     "name"
    t.integer  "local_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["local_id"], name: "index_tags_on_local_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "role",                            default: "moderator"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
