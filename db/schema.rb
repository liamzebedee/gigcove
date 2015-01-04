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

ActiveRecord::Schema.define(version: 20150104101459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres_gigs", id: false, force: true do |t|
    t.integer "genre_id"
    t.integer "gig_id"
  end

  create_table "gigs", force: true do |t|
    t.decimal  "cost",           default: 0.0
    t.datetime "start_datetime"
    t.string   "name",           default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderated",      default: false
    t.boolean  "approved",       default: false
    t.text     "link_to_source", default: ""
    t.integer  "venue_id"
    t.text     "description",    default: ""
    t.datetime "end_datetime"
    t.boolean  "eighteen_plus"
  end

  create_table "instagram_apis", force: true do |t|
    t.integer  "new_media_count"
    t.integer  "last_seen_instagram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instagram_media", force: true do |t|
    t.text     "link"
    t.integer  "instagram_id"
    t.datetime "created_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderated"
    t.boolean  "approved"
  end

  create_table "tags_gigs", id: false, force: true do |t|
    t.integer "tag_id"
    t.integer "gig_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderator"
    t.integer  "roles_mask"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "full_name"
    t.string   "gender"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.text     "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "approved"
    t.string   "cover_image"
  end

end
