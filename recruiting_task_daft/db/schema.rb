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

ActiveRecord::Schema.define(version: 2019_05_11_133238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discount_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "product_id"
    t.bigint "discount_id"
    t.index ["discount_id"], name: "index_discount_products_on_discount_id"
    t.index ["product_id"], name: "index_discount_products_on_product_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "kind", null: false
    t.string "name"
    t.float "price"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cart_id"
    t.index ["cart_id"], name: "index_discounts_on_cart_id"
    t.index ["name"], name: "index_discounts_on_name", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cart_id"
    t.bigint "product_id"
    t.index ["cart_id"], name: "index_items_on_cart_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  add_foreign_key "discount_products", "discounts"
  add_foreign_key "discount_products", "products"
  add_foreign_key "discounts", "carts"
  add_foreign_key "items", "carts"
  add_foreign_key "items", "products"
end
