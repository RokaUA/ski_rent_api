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

ActiveRecord::Schema.define(version: 2018_07_30_105111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "renter_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "cost_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_bookings_on_item_id"
    t.index ["renter_id"], name: "index_bookings_on_renter_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filters", force: :cascade do |t|
    t.bigint "category_id"
    t.string "filter_name"
    t.index ["category_id"], name: "index_filters_on_category_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "daily_price_cents"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["owner_id"], name: "index_items_on_owner_id"
  end

  create_table "items_options", id: false, force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "option_id"
    t.index ["item_id"], name: "index_items_options_on_item_id"
    t.index ["option_id"], name: "index_items_options_on_option_id"
  end

  create_table "money_transactions", force: :cascade do |t|
    t.bigint "payer_id"
    t.bigint "payee_id"
    t.string "target_type"
    t.bigint "target_id"
    t.integer "payment_cents"
    t.index ["payee_id"], name: "index_money_transactions_on_payee_id"
    t.index ["payer_id"], name: "index_money_transactions_on_payer_id"
    t.index ["target_type", "target_id"], name: "index_money_transactions_on_target_type_and_target_id"
  end

  create_table "options", force: :cascade do |t|
    t.bigint "filter_id"
    t.string "option_value"
    t.index ["filter_id"], name: "index_options_on_filter_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "author_id"
    t.text "description"
    t.string "reviewable_type"
    t.bigint "reviewable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_reviews_on_author_id"
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.integer "balance"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "bookings", "items"
  add_foreign_key "bookings", "users", column: "renter_id"
  add_foreign_key "filters", "categories"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "users", column: "owner_id"
  add_foreign_key "items_options", "items"
  add_foreign_key "items_options", "options"
  add_foreign_key "money_transactions", "users", column: "payee_id"
  add_foreign_key "money_transactions", "users", column: "payer_id"
  add_foreign_key "options", "filters"
  add_foreign_key "reviews", "users", column: "author_id"
  add_foreign_key "users", "cities"
end
