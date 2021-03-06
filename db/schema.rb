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

ActiveRecord::Schema.define(version: 20151028213838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rideprices", force: :cascade do |t|
    t.integer  "price"
    t.integer  "surge"
    t.datetime "time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "ride_id"
    t.string   "uber_ride_name"
  end

  add_index "rideprices", ["ride_id"], name: "index_rideprices_on_ride_id", using: :btree

  create_table "rides", force: :cascade do |t|
    t.string   "origin"
    t.string   "destination"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "user_id"
    t.float    "origin_latitude"
    t.float    "origin_longitude"
    t.float    "destination_latitude"
    t.float    "destination_longitude"
    t.string   "ride_name"
  end

  add_index "rides", ["user_id"], name: "index_rides_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "age"
    t.string   "gender"
    t.string   "home"
    t.string   "work"
    t.string   "avatar_file_name"
    t.string   "avatar_file_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_foreign_key "rideprices", "rides"
  add_foreign_key "rides", "users"
end
