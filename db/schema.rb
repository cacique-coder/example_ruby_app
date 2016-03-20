# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160117205442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "IVA", id: false, force: :cascade do |t|
    t.integer "id",      null: false
    t.float   "percent", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.integer "zone_id"
    t.string  "cliente",                          default: "", null: false
    t.text    "description"
    t.integer "status",                           default: 1,  null: false
    t.integer "zona_postal",                      default: 0,  null: false
    t.string  "cliente_optional",                 default: "", null: false
    t.string  "direction",                        default: "", null: false
    t.string  "rif",                              default: "", null: false
    t.integer "contribuyente_especial", limit: 2, default: 0,  null: false
    t.string  "telefono",                         default: "", null: false
    t.string  "saint_id",                         default: "", null: false
  end

  add_index "clients", ["zone_id"], name: "zone_id", using: :btree

  create_table "discounts", primary_key: "id_discount", force: :cascade do |t|
    t.string  "name",    limit: 45, null: false
    t.float   "percent",            null: false
    t.integer "day",     limit: 2,  null: false
  end

  create_table "mensajes", force: :cascade do |t|
    t.text     "asunto",  null: false
    t.text     "mensaje", null: false
    t.datetime "fecha",   null: false
  end

  create_table "migrations", id: false, force: :cascade do |t|
    t.integer "version", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "client_id",                          null: false
    t.datetime "created_at"
    t.float    "discount",                           null: false
    t.integer  "review",     limit: 2, default: 0,   null: false
    t.string   "saint_code", limit: 6, default: "0", null: false
    t.text     "comentario",                         null: false
    t.datetime "updated_at"
    t.datetime "time"
    t.integer  "user_id"
  end

  add_index "orders", ["client_id"], name: "client_id", using: :btree
  add_index "orders", ["user_id"], name: "order_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "code",           limit: 20,                  null: false
    t.string   "trademark",      limit: 100,                 null: false
    t.float    "price"
    t.datetime "updated_at",                                 null: false
    t.integer  "units",                      default: 0,     null: false
    t.string   "description",    limit: 150,                 null: false
    t.datetime "created_at"
    t.integer  "price_cents",                default: 0,     null: false
    t.string   "price_currency",             default: "USD", null: false
  end

  add_index "products", ["code"], name: "code_UNIQUE", unique: true, using: :btree

  create_table "products_orders", id: :bigserial, force: :cascade do |t|
    t.integer "order_id",                                  null: false
    t.string  "item_code",      limit: 20,                 null: false
    t.integer "quantity",                                  null: false
    t.integer "price_cents",               default: 0,     null: false
    t.string  "price_currency",            default: "USD", null: false
  end

  add_index "products_orders", ["item_code"], name: "item_code", using: :btree
  add_index "products_orders", ["order_id"], name: "order_id", using: :btree

  create_table "products_updated", id: false, force: :cascade do |t|
    t.integer "version", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",                  limit: 100,              null: false
    t.string   "name",                   limit: 100,              null: false
    t.string   "email",                  limit: 100,              null: false
    t.string   "type",                                            null: false
    t.integer  "status",                 limit: 2,                null: false
    t.string   "saint_id",               limit: 10,               null: false
    t.string   "token"
    t.string   "encrypted_password",                 default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zones", force: :cascade do |t|
    t.string  "login_user",  limit: 20
    t.string  "name",        limit: 45, null: false
    t.text    "description"
    t.integer "user_id"
  end

  add_index "zones", ["user_id"], name: "zone_user_id", using: :btree

end
