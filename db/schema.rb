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

ActiveRecord::Schema[7.0].define(version: 2024_12_02_115314) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assortments", force: :cascade do |t|
    t.integer "store_id", default: 0, null: false
    t.string "provider"
    t.string "product_group"
    t.string "product"
    t.integer "product_id"
    t.string "comment"
    t.decimal "remainder", precision: 10, scale: 2, default: "0.0"
    t.decimal "sales", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.string "organization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "provider"
    t.string "product_group"
    t.string "required"
    t.string "product"
    t.integer "day_store"
    t.decimal "sales", precision: 10, scale: 2, default: "0.0"
    t.decimal "remainder", precision: 10, scale: 2, default: "0.0"
    t.string "average_sales", default: "0"
    t.string "to_order"
    t.decimal "quantum", precision: 10, scale: 2, default: "0.0"
    t.integer "availability_order"
    t.integer "next_order"
    t.integer "cal_day_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "store_id", default: 0, null: false
    t.integer "colored", default: 0
  end

  create_table "profiles", force: :cascade do |t|
    t.string "full_name", default: "", null: false
    t.string "avatar"
    t.string "mobile"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_divisions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "division_id", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_user_divisions_on_division_id"
    t.index ["user_id"], name: "index_user_divisions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "type_role", default: 0, null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "user_divisions", "divisions"
  add_foreign_key "user_divisions", "users"
end
