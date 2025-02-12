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

ActiveRecord::Schema[7.1].define(version: 2024_02_28_093122) do
  create_table "products", force: :cascade do |t|
    t.integer "store_section_id", null: false
    t.string "name", limit: 128, null: false
    t.string "store_name", limit: 64
    t.boolean "purchased", default: false, null: false
    t.date "purchase_date", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_section_id"], name: "index_products_on_store_section_id"
    t.check_constraint "quantity >= 0", name: "quantity_positive_constraint"
  end

  create_table "store_sections", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "products", "store_sections"
end
