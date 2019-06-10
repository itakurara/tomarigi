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

ActiveRecord::Schema.define(version: 2019_06_09_122000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "zipcode", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_addresses_on_city"
    t.index ["prefecture"], name: "index_addresses_on_prefecture"
    t.index ["zipcode"], name: "index_addresses_on_zipcode"
  end

  create_table "birds", force: :cascade do |t|
    t.string "ja_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ja_name"], name: "index_birds_on_ja_name"
  end

  create_table "lost_birds", force: :cascade do |t|
    t.string "name"
    t.bigint "bird_id"
    t.bigint "address_id", null: false
    t.date "lost_at"
    t.date "found_at"
    t.string "ring_number"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_lost_birds_on_address_id"
    t.index ["bird_id"], name: "index_lost_birds_on_bird_id"
    t.index ["found_at"], name: "index_lost_birds_on_found_at"
    t.index ["lost_at"], name: "index_lost_birds_on_lost_at"
    t.index ["ring_number"], name: "index_lost_birds_on_ring_number"
  end

end
