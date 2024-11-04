# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_03_202939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string "address", null: false
    t.bigint "client_id", null: false
    t.bigint "zip_code_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_buildings_on_client_id"
    t.index ["zip_code_id"], name: "index_buildings_on_zip_code_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string "name", null: false
    t.integer "field_type", null: false
    t.json "enum_options"
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_custom_fields_on_client_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_states_on_code", unique: true
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "zip_codes", force: :cascade do |t|
    t.integer "code", null: false
    t.string "city", null: false
    t.bigint "state_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_zip_codes_on_code", unique: true
    t.index ["state_id"], name: "index_zip_codes_on_state_id"
  end

  add_foreign_key "buildings", "clients"
  add_foreign_key "buildings", "zip_codes"
  add_foreign_key "custom_fields", "clients"
  add_foreign_key "zip_codes", "states"
end
