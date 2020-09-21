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

ActiveRecord::Schema.define(version: 2020_09_21_005910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_ingredient_supplies", force: :cascade do |t|
    t.bigint "supply_id", null: false
    t.bigint "active_ingredient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["active_ingredient_id"], name: "index_active_ingredient_supplies_on_active_ingredient_id"
    t.index ["supply_id"], name: "index_active_ingredient_supplies_on_supply_id"
  end

  create_table "active_ingredients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

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

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "url"
    t.string "action"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "production_unit_id"
    t.decimal "jornals", precision: 8, scale: 2
    t.index ["production_unit_id"], name: "index_activities_on_production_unit_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.text "name"
    t.string "street"
    t.string "outdoor_number"
    t.string "interior_number"
    t.string "cp"
    t.string "references"
    t.string "neighborhood"
    t.string "phone"
    t.bigint "country_id", null: false
    t.bigint "state_id", null: false
    t.text "comments"
    t.integer "status"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "fiscal"
    t.string "crosses"
    t.string "locality"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
    t.index ["country_id"], name: "index_addresses_on_country_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.string "appointment_number"
    t.string "n_request"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "appointment_at"
    t.datetime "commitment_at"
    t.bigint "shipment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipment_id"], name: "index_appointments_on_shipment_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.string "territory"
    t.bigint "ranch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "irrigation_type_id"
    t.index ["irrigation_type_id"], name: "index_areas_on_irrigation_type_id"
    t.index ["ranch_id"], name: "index_areas_on_ranch_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.bigint "bank_id", null: false
    t.bigint "currency_id", null: false
    t.string "name"
    t.string "titular"
    t.string "bank_key"
    t.string "account_number"
    t.string "card_number"
    t.string "branch"
    t.string "accountable_type", null: false
    t.bigint "accountable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accountable_type", "accountable_id"], name: "index_bank_accounts_on_accountable_type_and_accountable_id"
    t.index ["bank_id"], name: "index_bank_accounts_on_bank_id"
    t.index ["currency_id"], name: "index_bank_accounts_on_currency_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.string "key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "client_brands", force: :cascade do |t|
    t.string "name"
    t.integer "client_id"
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

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "mobile_phone"
    t.string "position"
    t.integer "alias"
    t.string "contactable_type", null: false
    t.bigint "contactable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id", null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.boolean "all_products"
    t.bigint "delivery_address_id", null: false
    t.bigint "user_id", null: false
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "undefined"
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["delivery_address_id"], name: "index_contracts_on_delivery_address_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "contracts_expenses", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.bigint "expense_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id"], name: "index_contracts_expenses_on_contract_id"
    t.index ["expense_id"], name: "index_contracts_expenses_on_expense_id"
  end

  create_table "contracts_products", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.bigint "product_id", null: false
    t.bigint "currency_id", null: false
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id"], name: "index_contracts_products_on_contract_id"
    t.index ["currency_id"], name: "index_contracts_products_on_currency_id"
    t.index ["product_id"], name: "index_contracts_products_on_product_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "crop_damages", force: :cascade do |t|
    t.integer "crop_damageable_id"
    t.string "crop_damageable_type"
    t.integer "crop_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crop_damages_on_crop_id"
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

  create_table "crops_deseases", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "desease_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crops_deseases_on_crop_id"
    t.index ["desease_id"], name: "index_crops_deseases_on_desease_id"
  end

  create_table "crops_packages", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "package_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crops_packages_on_crop_id"
    t.index ["package_id"], name: "index_crops_packages_on_package_id"
  end

  create_table "crops_pests", force: :cascade do |t|
    t.bigint "crop_id", null: false
    t.bigint "pest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["crop_id"], name: "index_crops_pests_on_crop_id"
    t.index ["pest_id"], name: "index_crops_pests_on_pest_id"
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

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.boolean "national"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "damages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "deseases", force: :cascade do |t|
    t.string "name"
    t.string "scientific_name"
    t.string "pathogen"
    t.string "desease_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deseases_damages", force: :cascade do |t|
    t.bigint "desease_id", null: false
    t.bigint "damage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["damage_id"], name: "index_deseases_damages_on_damage_id"
    t.index ["desease_id"], name: "index_deseases_damages_on_desease_id"
  end

  create_table "deseases_hosts", force: :cascade do |t|
    t.bigint "desease_id", null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["desease_id"], name: "index_deseases_hosts_on_desease_id"
    t.index ["host_id"], name: "index_deseases_hosts_on_host_id"
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

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fiscals", force: :cascade do |t|
    t.string "bussiness_name"
    t.string "rfc"
    t.string "fiscalable_type", null: false
    t.bigint "fiscalable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fiscalable_type", "fiscalable_id"], name: "index_fiscals_on_fiscalable_type_and_fiscalable_id"
  end

  create_table "freights", force: :cascade do |t|
    t.bigint "carrier_id"
    t.bigint "driver_id"
    t.bigint "unit_id"
    t.bigint "box_id"
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "folio"
    t.integer "pay_freight"
    t.boolean "pay_company"
    t.decimal "cost"
    t.integer "currency"
    t.string "invoice_serie"
    t.integer "invoice_total"
    t.string "debtable_type"
    t.bigint "debtable_id"
    t.index ["box_id"], name: "index_freights_on_box_id"
    t.index ["carrier_id"], name: "index_freights_on_carrier_id"
    t.index ["debtable_type", "debtable_id"], name: "index_freights_on_debtable_type_and_debtable_id"
    t.index ["driver_id"], name: "index_freights_on_driver_id"
    t.index ["unit_id"], name: "index_freights_on_unit_id"
    t.index ["user_id"], name: "index_freights_on_user_id"
  end

  create_table "freights_taxes", force: :cascade do |t|
    t.bigint "freight_id", null: false
    t.bigint "tax_id", null: false
    t.decimal "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["freight_id"], name: "index_freights_taxes_on_freight_id"
    t.index ["tax_id"], name: "index_freights_taxes_on_tax_id"
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

  create_table "hosts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "irrigation_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "perforations", force: :cascade do |t|
    t.string "name"
    t.string "coordinates"
    t.string "registry_number"
    t.string "volume"
    t.date "validity"
    t.decimal "expenditure"
    t.bigint "ranch_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ranch_id"], name: "index_perforations_on_ranch_id"
  end

  create_table "pests", force: :cascade do |t|
    t.string "name"
    t.string "scientific_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pests_damages", force: :cascade do |t|
    t.bigint "pest_id", null: false
    t.bigint "damage_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["damage_id"], name: "index_pests_damages_on_damage_id"
    t.index ["pest_id"], name: "index_pests_damages_on_pest_id"
  end

  create_table "pests_hosts", force: :cascade do |t|
    t.bigint "pest_id", null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["host_id"], name: "index_pests_hosts_on_host_id"
    t.index ["pest_id"], name: "index_pests_hosts_on_pest_id"
  end

  create_table "presentation_supplies", force: :cascade do |t|
    t.bigint "supply_id", null: false
    t.bigint "presentation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["presentation_id"], name: "index_presentation_supplies_on_presentation_id"
    t.index ["supply_id"], name: "index_presentation_supplies_on_supply_id"
  end

  create_table "presentations", force: :cascade do |t|
    t.string "name"
    t.decimal "quantity"
    t.decimal "price"
    t.decimal "price_to_credit"
    t.bigint "weight_unit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["weight_unit_id"], name: "index_presentations_on_weight_unit_id"
  end

  create_table "production_units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "weight_unit_id"
    t.decimal "weight"
    t.index ["weight_unit_id"], name: "index_production_units_on_weight_unit_id"
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

  create_table "provider_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.string "business_name"
    t.string "rfc"
    t.string "email"
    t.string "phone"
    t.integer "status"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_category_id", null: false
    t.bigint "subcategory_id", null: false
    t.index ["provider_category_id"], name: "index_providers_on_provider_category_id"
    t.index ["subcategory_id"], name: "index_providers_on_subcategory_id"
  end

  create_table "qualities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "short_name"
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "company_id", null: false
    t.bigint "contact_id", null: false
    t.bigint "user_id", null: false
    t.integer "expirated_days"
    t.date "expired_at"
    t.string "folio"
    t.decimal "iva"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "issue_at"
    t.decimal "discount"
    t.bigint "delivery_address_id", null: false
    t.index ["client_id"], name: "index_quotes_on_client_id"
    t.index ["company_id"], name: "index_quotes_on_company_id"
    t.index ["contact_id"], name: "index_quotes_on_contact_id"
    t.index ["delivery_address_id"], name: "index_quotes_on_delivery_address_id"
    t.index ["user_id"], name: "index_quotes_on_user_id"
  end

  create_table "ranches", force: :cascade do |t|
    t.bigint "state_id"
    t.bigint "municipality_id"
    t.bigint "manager_id"
    t.string "territory"
    t.string "hydrological_region"
    t.string "aquifer_name"
    t.string "georeference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["manager_id"], name: "index_ranches_on_manager_id"
    t.index ["municipality_id"], name: "index_ranches_on_municipality_id"
    t.index ["state_id"], name: "index_ranches_on_state_id"
  end

  create_table "shipments", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "client_id", null: false
    t.bigint "delivery_address_id", null: false
    t.integer "pay_freight"
    t.text "comments"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.bigint "freight_id"
    t.integer "n_products"
    t.string "folio"
    t.string "client_folio"
    t.string "freight_folio"
    t.bigint "user_id"
    t.bigint "contact_id"
    t.datetime "issue_at"
    t.integer "expirated_days"
    t.integer "iva"
    t.integer "discount"
    t.string "quote_folio"
    t.integer "currency"
    t.decimal "exchange_rate"
    t.string "order_sale_folio"
    t.boolean "cancel_quote", default: false
    t.boolean "cancel_sale_order", default: false
    t.boolean "cancel_sale", default: false
    t.datetime "shipment_at"
    t.index ["client_id"], name: "index_shipments_on_client_id"
    t.index ["company_id"], name: "index_shipments_on_company_id"
    t.index ["contact_id"], name: "index_shipments_on_contact_id"
    t.index ["delivery_address_id"], name: "index_shipments_on_delivery_address_id"
    t.index ["freight_id"], name: "index_shipments_on_freight_id"
    t.index ["user_id"], name: "index_shipments_on_user_id"
  end

  create_table "shipments_products", force: :cascade do |t|
    t.bigint "shipment_id"
    t.bigint "product_id", null: false
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity"
    t.string "productable_type"
    t.bigint "productable_id"
    t.integer "measurement_unit"
    t.integer "unit_meassure"
    t.index ["product_id"], name: "index_shipments_products_on_product_id"
    t.index ["productable_type", "productable_id"], name: "index_shipments_products_on_productable_type_and_productable_id"
    t.index ["shipment_id"], name: "index_shipments_products_on_shipment_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "short_name"
  end

  create_table "stages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  create_table "sub_stages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "categorytable_type", null: false
    t.bigint "categorytable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["categorytable_type", "categorytable_id"], name: "index_subcategories_on_categorytable_type_and_categorytable_id"
  end

  create_table "supplies", force: :cascade do |t|
    t.string "name"
    t.integer "currency"
    t.decimal "iva"
    t.decimal "ieps"
    t.bigint "category_id", null: false
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_supplies_on_category_id"
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

  create_table "unit_measures", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "unit_times", force: :cascade do |t|
    t.string "name"
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

  create_table "weight_units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_ingredient_supplies", "active_ingredients"
  add_foreign_key "active_ingredient_supplies", "supplies"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "users"
  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "states"
  add_foreign_key "appointments", "shipments"
  add_foreign_key "areas", "ranches"
  add_foreign_key "bank_accounts", "banks"
  add_foreign_key "bank_accounts", "currencies"
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
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "delivery_addresses"
  add_foreign_key "contracts", "users"
  add_foreign_key "contracts_expenses", "contracts"
  add_foreign_key "contracts_expenses", "expenses"
  add_foreign_key "contracts_products", "contracts"
  add_foreign_key "contracts_products", "currencies"
  add_foreign_key "contracts_products", "products"
  add_foreign_key "crops_colors", "colors"
  add_foreign_key "crops_colors", "crops"
  add_foreign_key "crops_deseases", "crops"
  add_foreign_key "crops_deseases", "deseases"
  add_foreign_key "crops_packages", "crops"
  add_foreign_key "crops_packages", "packages"
  add_foreign_key "crops_pests", "crops"
  add_foreign_key "crops_pests", "pests"
  add_foreign_key "crops_qualities", "crops"
  add_foreign_key "crops_qualities", "qualities"
  add_foreign_key "crops_sizes", "crops"
  add_foreign_key "crops_sizes", "sizes"
  add_foreign_key "delivery_addresses", "clients"
  add_foreign_key "delivery_addresses", "countries"
  add_foreign_key "delivery_addresses", "municipalities"
  add_foreign_key "delivery_addresses", "states"
  add_foreign_key "deseases_damages", "damages"
  add_foreign_key "deseases_damages", "deseases"
  add_foreign_key "deseases_hosts", "deseases"
  add_foreign_key "deseases_hosts", "hosts"
  add_foreign_key "drivers", "carriers"
  add_foreign_key "freights", "boxes"
  add_foreign_key "freights", "carriers"
  add_foreign_key "freights", "drivers"
  add_foreign_key "freights", "units"
  add_foreign_key "freights", "users"
  add_foreign_key "freights_taxes", "freights"
  add_foreign_key "freights_taxes", "taxes"
  add_foreign_key "general_information", "users"
  add_foreign_key "municipalities", "states"
  add_foreign_key "perforations", "ranches"
  add_foreign_key "pests_damages", "damages"
  add_foreign_key "pests_damages", "pests"
  add_foreign_key "pests_hosts", "hosts"
  add_foreign_key "pests_hosts", "pests"
  add_foreign_key "presentation_supplies", "presentations"
  add_foreign_key "presentation_supplies", "supplies"
  add_foreign_key "presentations", "weight_units"
  add_foreign_key "production_units", "weight_units"
  add_foreign_key "products", "client_brands"
  add_foreign_key "products", "colors"
  add_foreign_key "products", "crops"
  add_foreign_key "products", "packages"
  add_foreign_key "products", "qualities"
  add_foreign_key "products", "sizes"
  add_foreign_key "providers", "provider_categories"
  add_foreign_key "providers", "subcategories"
  add_foreign_key "quotes", "clients"
  add_foreign_key "quotes", "companies"
  add_foreign_key "quotes", "contacts"
  add_foreign_key "quotes", "delivery_addresses"
  add_foreign_key "quotes", "users"
  add_foreign_key "shipments", "clients"
  add_foreign_key "shipments", "companies"
  add_foreign_key "shipments", "contacts"
  add_foreign_key "shipments", "delivery_addresses"
  add_foreign_key "shipments", "freights"
  add_foreign_key "shipments", "users"
  add_foreign_key "shipments_products", "products"
  add_foreign_key "shipments_products", "shipments"
  add_foreign_key "states", "countries"
  add_foreign_key "supplies", "categories"
  add_foreign_key "units", "carriers"
  add_foreign_key "units", "unit_brands"
end
