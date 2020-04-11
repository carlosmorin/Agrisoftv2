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

ActiveRecord::Schema.define(version: 2020_04_10_191815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "box_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "boxes", force: :cascade do |t|
    t.string "temperature"
    t.string "plate_number"
    t.string "n_econ"
    t.bigint "carrier_id", null: false
    t.bigint "box_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["box_type_id"], name: "index_boxes_on_box_type_id"
    t.index ["carrier_id"], name: "index_boxes_on_carrier_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "name"
    t.string "rfc"
    t.string "phone"
    t.string "country"
    t.string "state"
    t.string "address"
    t.string "cp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "municipality"
    t.string "caat"
    t.string "alpha"
    t.string "iccmx"
    t.string "usdot"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "rfc"
    t.string "phone"
    t.string "country"
    t.string "state"
    t.string "cp"
    t.string "address"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "phone"
    t.string "licence"
    t.bigint "carrier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["carrier_id"], name: "index_drivers_on_carrier_id"
  end

  create_table "general_information", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.datetime "born_date"
    t.string "alias"
    t.string "level_studies"
    t.string "school_name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_general_information_on_user_id"
  end

  create_table "localities", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.integer "municipality_id", null: false
    t.string "key", null: false
    t.string "name", null: false
    t.string "latitude", null: false
    t.string "length", null: false
    t.string "alt", null: false
    t.string "card", null: false
    t.string "ambit", null: false
    t.integer "population", null: false
    t.integer "male", null: false
    t.integer "female", null: false
    t.integer "households", null: false
    t.decimal "lat", precision: 10, scale: 7, null: false
    t.decimal "lng", precision: 10, scale: 7, null: false
    t.integer "active", default: 1, null: false
  end

  create_table "municipalities", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.integer "state_id", null: false
    t.string "key", limit: 3, null: false
    t.string "name", limit: 100, null: false
    t.integer "active", default: 1, null: false
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "carrier_id", null: false
    t.bigint "driver_id", null: false
    t.bigint "unit_id", null: false
    t.bigint "box_id", null: false
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["box_id"], name: "index_shipments_on_box_id"
    t.index ["carrier_id"], name: "index_shipments_on_carrier_id"
    t.index ["driver_id"], name: "index_shipments_on_driver_id"
    t.index ["unit_id"], name: "index_shipments_on_unit_id"
    t.index ["user_id"], name: "index_shipments_on_user_id"
  end

  create_table "states", id: false, force: :cascade do |t|
    t.integer "id", null: false
    t.string "key", limit: 2, null: false
    t.string "name", limit: 40, null: false
    t.string "short_name", limit: 10, null: false
    t.bigint "country_id"
    t.index ["country_id"], name: "index_states_on_country_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "unit_brands", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "model"
    t.string "color"
    t.string "year"
    t.string "n_econ"
    t.string "plate_number"
    t.bigint "carrier_id", null: false
    t.bigint "unit_brand_id", null: false
    t.index ["carrier_id"], name: "index_units_on_carrier_id"
    t.index ["unit_brand_id"], name: "index_units_on_unit_brand_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "last_name"
    t.boolean "deactivated"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boxes", "box_types"
  add_foreign_key "boxes", "carriers"
  add_foreign_key "drivers", "carriers"
  add_foreign_key "general_information", "users"
  add_foreign_key "shipments", "boxes"
  add_foreign_key "shipments", "carriers"
  add_foreign_key "shipments", "drivers"
  add_foreign_key "shipments", "units"
  add_foreign_key "shipments", "users"
  add_foreign_key "states", "countries"
  add_foreign_key "units", "carriers"
  add_foreign_key "units", "unit_brands"
end
