# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_29_201323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "region"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "global_warmings", force: :cascade do |t|
    t.string "city"
    t.integer "time_change"
    t.integer "slope"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_global_warmings_on_city_id"
  end

  create_table "temps", force: :cascade do |t|
    t.datetime "date"
    t.integer "temp_high"
    t.integer "temp_mid"
    t.integer "temp_low"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sunset"
    t.integer "current_temp"
    t.datetime "sunset_datetime"
    t.index ["city_id"], name: "index_temps_on_city_id"
  end

  add_foreign_key "global_warmings", "cities"
  add_foreign_key "temps", "cities"
end
