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

ActiveRecord::Schema.define(version: 20170108114637) do

  create_table "agreement_renters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "agreement_id"
    t.integer  "renter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["agreement_id"], name: "index_agreement_renters_on_agreement_id", using: :btree
    t.index ["renter_id"], name: "index_agreement_renters_on_renter_id", using: :btree
    t.index ["user_id"], name: "index_agreement_renters_on_user_id", using: :btree
  end

  create_table "agreement_services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "agreement_id"
    t.integer  "service_id"
    t.integer  "amount_perservice"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "status"
    t.index ["agreement_id"], name: "index_agreement_services_on_agreement_id", using: :btree
    t.index ["service_id"], name: "index_agreement_services_on_service_id", using: :btree
    t.index ["user_id"], name: "index_agreement_services_on_user_id", using: :btree
  end

  create_table "agreements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.integer  "renter_id"
    t.string   "code"
    t.integer  "duration"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "out_date"
    t.integer  "down_payment"
    t.integer  "pre_payment"
    t.integer  "billing_cycle"
    t.integer  "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "month_pre_payment"
    t.index ["renter_id"], name: "index_agreements_on_renter_id", using: :btree
    t.index ["room_id"], name: "index_agreements_on_room_id", using: :btree
    t.index ["user_id"], name: "index_agreements_on_user_id", using: :btree
  end

  create_table "bill_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.integer  "service_id"
    t.integer  "amount"
    t.integer  "unit_price"
    t.integer  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_bill_details_on_bill_id", using: :btree
    t.index ["service_id"], name: "index_bill_details_on_service_id", using: :btree
    t.index ["user_id"], name: "index_bill_details_on_user_id", using: :btree
  end

  create_table "bills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "agreement_id"
    t.integer  "year"
    t.integer  "month"
    t.string   "code"
    t.datetime "bill_date"
    t.integer  "other_cost"
    t.integer  "debt_amount"
    t.integer  "total_amount"
    t.integer  "payment_amount"
    t.integer  "remain_amount"
    t.string   "description",    limit: 500
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "room_id"
    t.integer  "pre_payment"
    t.integer  "status"
    t.index ["agreement_id"], name: "index_bills_on_agreement_id", using: :btree
    t.index ["room_id"], name: "index_bills_on_room_id", using: :btree
    t.index ["user_id"], name: "index_bills_on_user_id", using: :btree
  end

  create_table "buildings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "code"
    t.string   "name"
    t.string   "description", limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["parent_id"], name: "index_buildings_on_parent_id", using: :btree
    t.index ["user_id"], name: "index_buildings_on_user_id", using: :btree
  end

  create_table "config_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "value"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "configs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "value"
    t.string   "description",        limit: 500
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "config_category_id"
    t.string   "label"
    t.index ["config_category_id"], name: "index_configs_on_config_category_id", using: :btree
    t.index ["user_id"], name: "index_configs_on_user_id", using: :btree
  end

  create_table "electricity_waters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.integer  "year"
    t.integer  "month"
    t.integer  "start_electricity"
    t.integer  "end_electricity"
    t.integer  "total_electricity"
    t.integer  "start_water"
    t.integer  "end_water"
    t.integer  "total_water"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["room_id"], name: "index_electricity_waters_on_room_id", using: :btree
    t.index ["user_id"], name: "index_electricity_waters_on_user_id", using: :btree
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["user_id"], name: "index_feedbacks_on_user_id", using: :btree
  end

  create_table "functions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.string   "controller"
    t.string   "description", limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["parent_id"], name: "index_functions_on_parent_id", using: :btree
  end

  create_table "group_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "group_id"
    t.integer  "function_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["function_id"], name: "index_group_permissions_on_function_id", using: :btree
    t.index ["group_id"], name: "index_group_permissions_on_group_id", using: :btree
    t.index ["permission_id"], name: "index_group_permissions_on_permission_id", using: :btree
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "level"
    t.string   "description", limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "payment_bills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "name"
    t.datetime "payment_date"
    t.integer  "payment_type"
    t.integer  "amount"
    t.string   "unit"
    t.integer  "unit_price"
    t.integer  "payment"
    t.string   "description",  limit: 500
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "building_id"
    t.index ["building_id"], name: "index_payment_bills_on_building_id", using: :btree
    t.index ["user_id"], name: "index_payment_bills_on_user_id", using: :btree
  end

  create_table "permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "value"
    t.string   "description", limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "renters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "code"
    t.string   "name"
    t.datetime "birthday"
    t.integer  "sex"
    t.string   "identity_card"
    t.string   "issued_card"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.integer  "career"
    t.string   "university"
    t.string   "parent_name"
    t.string   "parent_phone"
    t.string   "hometown"
    t.integer  "temporary_registration"
    t.integer  "owner"
    t.string   "description",            limit: 500
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["user_id"], name: "index_renters_on_user_id", using: :btree
  end

  create_table "room_devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.string   "name"
    t.integer  "amount"
    t.integer  "status"
    t.string   "description", limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["room_id"], name: "index_room_devices_on_room_id", using: :btree
    t.index ["user_id"], name: "index_room_devices_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "building_id"
    t.string   "code"
    t.string   "name"
    t.integer  "room_type"
    t.integer  "amount"
    t.integer  "cost"
    t.integer  "status"
    t.string   "description", limit: 500
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["building_id"], name: "index_rooms_on_building_id", using: :btree
    t.index ["user_id"], name: "index_rooms_on_user_id", using: :btree
  end

  create_table "services", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "building_id"
    t.string   "name"
    t.string   "unit"
    t.integer  "unit_price"
    t.string   "description",  limit: 500
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "code"
    t.integer  "service_type"
    t.index ["building_id"], name: "index_services_on_building_id", using: :btree
    t.index ["user_id"], name: "index_services_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "group_id"
    t.string   "password"
    t.string   "name"
    t.integer  "age"
    t.integer  "sex"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.integer  "actived"
    t.string   "aggrementno"
    t.string   "description",            limit: 500
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["group_id"], name: "index_users_on_group_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "agreement_renters", "agreements"
  add_foreign_key "agreement_renters", "renters"
  add_foreign_key "agreement_renters", "users"
  add_foreign_key "agreement_services", "agreements"
  add_foreign_key "agreement_services", "services"
  add_foreign_key "agreement_services", "users"
  add_foreign_key "agreements", "renters"
  add_foreign_key "agreements", "rooms"
  add_foreign_key "agreements", "users"
  add_foreign_key "bill_details", "bills"
  add_foreign_key "bill_details", "services"
  add_foreign_key "bill_details", "users"
  add_foreign_key "bills", "agreements"
  add_foreign_key "bills", "rooms"
  add_foreign_key "bills", "users"
  add_foreign_key "buildings", "users"
  add_foreign_key "configs", "config_categories"
  add_foreign_key "configs", "users"
  add_foreign_key "electricity_waters", "rooms"
  add_foreign_key "electricity_waters", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "group_permissions", "functions"
  add_foreign_key "group_permissions", "groups"
  add_foreign_key "group_permissions", "permissions"
  add_foreign_key "payment_bills", "buildings"
  add_foreign_key "payment_bills", "users"
  add_foreign_key "renters", "users"
  add_foreign_key "room_devices", "rooms"
  add_foreign_key "room_devices", "users"
  add_foreign_key "rooms", "buildings"
  add_foreign_key "rooms", "users"
  add_foreign_key "services", "buildings"
  add_foreign_key "services", "users"
  add_foreign_key "users", "groups"
end
