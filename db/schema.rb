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

ActiveRecord::Schema.define(version: 2020_04_29_215814) do

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
    t.string "name"
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
    t.string "caat"
    t.string "alpha"
    t.string "iccmx"
    t.string "usdot"
    t.bigint "country_id", null: false
    t.bigint "state_id", null: false
    t.bigint "municipality_id", null: false
    t.string "email"
    t.string "contact_name"
    t.index ["country_id"], name: "index_carriers_on_country_id"
    t.index ["municipality_id"], name: "index_carriers_on_municipality_id"
    t.index ["state_id"], name: "index_carriers_on_state_id"
  end

  create_table "client_brands", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_client_brands_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "rfc"
    t.string "phone"
    t.string "address"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email"
    t.bigint "state_id"
    t.bigint "country_id"
    t.bigint "municipality_id"
    t.string "cp"
    t.string "contact_name"
    t.string "code"
    t.string "shipments"
    t.index ["country_id"], name: "index_clients_on_country_id"
    t.index ["municipality_id"], name: "index_clients_on_municipality_id"
    t.index ["state_id"], name: "index_clients_on_state_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "rfc"
    t.string "phone"
    t.bigint "country_id", null: false
    t.bigint "state_id", null: false
    t.bigint "municipality_id", null: false
    t.string "cp", null: false
    t.string "address"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "contact_name"
    t.index ["country_id"], name: "index_companies_on_country_id"
    t.index ["municipality_id"], name: "index_companies_on_municipality_id"
    t.index ["state_id"], name: "index_companies_on_state_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "crops", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "crops_colors", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "color_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["color_id"], name: "index_crops_colors_on_color_id"
    t.index ["crop_id"], name: "index_crops_colors_on_crop_id"
  end

  create_table "crops_packages", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "package_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crops_packages_on_crop_id"
    t.index ["package_id"], name: "index_crops_packages_on_package_id"
  end

  create_table "crops_qualities", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "quality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crops_qualities_on_crop_id"
    t.index ["quality_id"], name: "index_crops_qualities_on_quality_id"
  end

  create_table "crops_sizes", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "size_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crops_sizes_on_crop_id"
    t.index ["size_id"], name: "index_crops_sizes_on_size_id"
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "country_id", null: false
    t.bigint "state_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "municipality_id", null: false
    t.string "address"
    t.string "phone"
    t.text "comments"
    t.string "name"
    t.string "contact_name"
    t.string "email"
    t.boolean "external"
    t.index ["client_id"], name: "index_delivery_addresses_on_client_id"
    t.index ["country_id"], name: "index_delivery_addresses_on_country_id"
    t.index ["municipality_id"], name: "index_delivery_addresses_on_municipality_id"
    t.index ["state_id"], name: "index_delivery_addresses_on_state_id"
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
    t.string "full_name"
    t.index ["carrier_id"], name: "index_drivers_on_carrier_id"
  end

  create_table "freights", force: :cascade do |t|
    t.bigint "carrier_id", null: false
    t.bigint "driver_id", null: false
    t.bigint "unit_id", null: false
    t.bigint "box_id", null: false
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "folio"
    t.boolean "pay_client"
    t.boolean "pay_company"
    t.decimal "cost"
    t.integer "currency"
    t.index ["box_id"], name: "index_freights_on_box_id"
    t.index ["carrier_id"], name: "index_freights_on_carrier_id"
    t.index ["driver_id"], name: "index_freights_on_driver_id"
    t.index ["unit_id"], name: "index_freights_on_unit_id"
    t.index ["user_id"], name: "index_freights_on_user_id"
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

  create_table "municipalities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "key"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active"
    t.index ["state_id"], name: "index_municipalities_on_state_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "color_id", null: false
    t.bigint "quality_id", null: false
    t.bigint "size_id", null: false
    t.bigint "package_id", null: false
    t.bigint "client_brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.decimal "weight"
    t.integer "unit_meassure"
    t.index ["client_brand_id"], name: "index_products_on_client_brand_id"
    t.index ["color_id"], name: "index_products_on_color_id"
    t.index ["crop_id"], name: "index_products_on_crop_id"
    t.index ["package_id"], name: "index_products_on_package_id"
    t.index ["quality_id"], name: "index_products_on_quality_id"
    t.index ["size_id"], name: "index_products_on_size_id"
  end

  create_table "qualities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "short_name"
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "client_id", null: false
    t.bigint "delivery_address_id", null: false
    t.boolean "pay_freight"
    t.text "comments"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.bigint "freight_id", null: false
    t.integer "n_products"
    t.string "folio"
    t.string "client_folio"
    t.string "freight_folio"
    t.index ["client_id"], name: "index_shipments_on_client_id"
    t.index ["company_id"], name: "index_shipments_on_company_id"
    t.index ["delivery_address_id"], name: "index_shipments_on_delivery_address_id"
    t.index ["freight_id"], name: "index_shipments_on_freight_id"
  end

  create_table "shipments_products", force: :cascade do |t|
    t.bigint "shipment_id", null: false
    t.bigint "product_id", null: false
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity"
    t.index ["product_id"], name: "index_shipments_products_on_product_id"
    t.index ["shipment_id"], name: "index_shipments_products_on_shipment_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "short_name"
  end

  create_table "states", force: :cascade do |t|
    t.string "key"
    t.string "name"
    t.string "short_name"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "name"
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
  add_foreign_key "carriers", "countries"
  add_foreign_key "carriers", "municipalities"
  add_foreign_key "carriers", "states"
  add_foreign_key "client_brands", "clients"
  add_foreign_key "clients", "countries"
  add_foreign_key "clients", "municipalities"
  add_foreign_key "clients", "states"
  add_foreign_key "companies", "countries"
  add_foreign_key "companies", "municipalities"
  add_foreign_key "companies", "states"
  add_foreign_key "crops_colors", "colors"
  add_foreign_key "crops_colors", "crops"
  add_foreign_key "crops_packages", "crops"
  add_foreign_key "crops_packages", "packages"
  add_foreign_key "crops_qualities", "crops"
  add_foreign_key "crops_qualities", "qualities"
  add_foreign_key "crops_sizes", "crops"
  add_foreign_key "crops_sizes", "sizes"
  add_foreign_key "delivery_addresses", "clients"
  add_foreign_key "delivery_addresses", "countries"
  add_foreign_key "delivery_addresses", "municipalities"
  add_foreign_key "delivery_addresses", "states"
  add_foreign_key "drivers", "carriers"
  add_foreign_key "freights", "boxes"
  add_foreign_key "freights", "carriers"
  add_foreign_key "freights", "drivers"
  add_foreign_key "freights", "units"
  add_foreign_key "freights", "users"
  add_foreign_key "general_information", "users"
  add_foreign_key "municipalities", "states"
  add_foreign_key "products", "client_brands"
  add_foreign_key "products", "colors"
  add_foreign_key "products", "crops"
  add_foreign_key "products", "packages"
  add_foreign_key "products", "qualities"
  add_foreign_key "products", "sizes"
  add_foreign_key "shipments", "clients"
  add_foreign_key "shipments", "companies"
  add_foreign_key "shipments", "delivery_addresses"
  add_foreign_key "shipments", "freights"
  add_foreign_key "shipments_products", "products"
  add_foreign_key "shipments_products", "shipments"
  add_foreign_key "states", "countries"
  add_foreign_key "units", "carriers"
  add_foreign_key "units", "unit_brands"
end
