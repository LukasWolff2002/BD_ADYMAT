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

ActiveRecord::Schema[7.1].define(version: 2025_06_25_140709) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "nombre"
    t.string "rut", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "machineries", force: :cascade do |t|
    t.string "nombre"
    t.string "formato"
    t.integer "horas_por_mantencion"
    t.integer "horas_totales"
    t.integer "horas_disponibles"
    t.integer "valor_dia"
    t.integer "valor_semana"
    t.integer "valor_mes"
    t.string "qr_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qr_token"], name: "index_machineries_on_qr_token", unique: true
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "machinery_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "payment_method"
    t.string "payment_status"
    t.text "observations"
    t.decimal "discount", precision: 10, scale: 2
    t.decimal "freight", precision: 10, scale: 2
    t.decimal "total_amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machinery_id"], name: "index_rentals_on_machinery_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.bigint "machinery_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "payment_method"
    t.string "payment_status"
    t.text "observations"
    t.decimal "discount", precision: 10, scale: 2
    t.decimal "freight", precision: 10, scale: 2
    t.decimal "total_amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machinery_id"], name: "index_rentals_on_machinery_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "rut", null: false
    t.string "email", null: false
    t.string "cargo"
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cargo"], name: "index_users_on_cargo"
    t.index ["rut"], name: "index_users_on_rut"
  end

  add_foreign_key "rentals", "machineries"
end
