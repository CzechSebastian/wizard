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

ActiveRecord::Schema.define(version: 2019_06_06_163422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.jsonb "coordinates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "restaurant_score", default: 0.0
    t.jsonb "raw_restaurant"
    t.float "school_score", default: 0.0
    t.jsonb "school_raw"
    t.float "quiet_score", default: 0.0
    t.jsonb "quiet_raw"
    t.jsonb "location"
    t.float "subway_score", default: 0.0
    t.jsonb "subway_raw"
    t.float "average", default: 0.0
    t.float "park_score", default: 0.0
    t.jsonb "park_raw"
    t.float "bixi_score", default: 0.0
    t.jsonb "bixi_raw", default: []
    t.float "parking_score", default: 0.0
    t.jsonb "parking_raw", default: []
    t.float "dog_score", default: 0.0
    t.jsonb "dog_raw", default: []
    t.float "bar_score", default: 0.0
    t.jsonb "bar_raw", default: []
    t.float "cafe_score", default: 0.0
    t.jsonb "cafe_raw", default: []
    t.float "gym_score", default: 0.0
    t.jsonb "gym_raw", default: []
    t.string "language", default: "French"
    t.string "crime_rate", default: "Low"
    t.integer "age", default: 30
    t.integer "rent_rate", default: 900
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
