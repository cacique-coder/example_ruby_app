class FirstMigration < ActiveRecord::Migration
  def change
    ActiveRecord::Schema.define(version: 0) do

      create_table "IVA", id: false do |t|
        t.integer "id",      limit: 4,  null: false
        t.float   "percent", limit: 24, null: false
      end

      create_table "clients" do |t|
        t.integer "zone_id",                limit: 4,                     null: false
        t.string  "cliente",                limit: 100,                   null: false
        t.text    "description",            limit: 65535,                 null: false
        t.integer "status",                 limit: 1,                     null: false
        t.integer "zona_postal",            limit: 4,                     null: false
        t.string  "cliente_optional",       limit: 200,                   null: false
        t.string  "direction",              limit: 200,                   null: false
        t.string  "rif",                    limit: 12,                    null: false
        t.integer "contribuyente_especial", limit: 1,     default: 0, null: false
        t.string  "telefono",               limit: 100,                   null: false
        t.string  "saint_id",               limit: 10,                    null: false
      end

      add_index "clients", ["zone_id"], name: "zone_id", using: :btree

      create_table "discounts", primary_key: "id_discount" do |t|
        t.string  "name",    limit: 45, null: false
        t.float   "porcent", limit: 24, null: false
        t.integer "day",     limit: 1,  null: false
      end

      create_table "mensajes" do |t|
        t.text     "asunto",  limit: 65535, null: false
        t.text     "mensaje", limit: 65535, null: false
        t.datetime "fecha",                 null: false
      end

      create_table "migrations", id: false do |t|
        t.integer "version", limit: 4, null: false
      end

      create_table "orders" do |t|
        t.string   "login_user",   limit: 20,                    null: false
        t.integer  "client_id",    limit: 4,                     null: false
        t.datetime "date_created"
        t.float    "discount",     limit: 24,                    null: false
        t.integer  "review",       limit: 1,     default: 0, null: false
        t.string   "saint_code",   limit: 6,     default: "0",   null: false
        t.string   "status",       limit: 150,                   null: false
        t.text     "comentario",   limit: 65535,                 null: false
        t.datetime "date_updated"
        t.datetime "time"
      end

      add_index "orders", ["client_id"], name: "client_id", using: :btree
      add_index "orders", ["login_user"], name: "login_user", using: :btree

      create_table "products" do |t|
        t.string   "code",          limit: 20,              null: false
        t.string   "trademark",     limit: 100,             null: false
        t.float    "price",         limit: 24,              null: false
        t.datetime "date_updated_",                         null: false
        t.integer  "units",         limit: 4,   default: 0, null: false
        t.string   "description",   limit: 150,             null: false
      end

      add_index "products", ["code"], name: "code_UNIQUE", unique: true, using: :btree

      create_table "products_orders", id: false do |t|
        t.integer "order_id",  limit: 4,  null: false
        t.string  "item_code", limit: 20, null: false
        t.integer "quantity",  limit: 4,  null: false
      end

      add_index "products_orders", ["item_code"], name: "item_code", using: :btree
      add_index "products_orders", ["order_id"], name: "order_id", using: :btree

      create_table "products_updated", id: false do |t|
        t.integer "version", limit: 4, null: false
      end

      create_table "users" do |t|
        t.string  "login",     limit: 100, null: false
        t.string  "name",      limit: 100, null: false
        t.string  "password",  limit: 100
        t.string  "email",     limit: 100, null: false
        t.string "type",   null: false
        t.integer "status",    limit: 1,   null: false
        t.string  "saint_id",  limit: 10,  null: false
        t.string  "token",     limit: 33,  null: false
      end

      create_table "zones" do |t|
        t.string "login_user",  limit: 20
        t.string "name",        limit: 45,    null: false
        t.text   "description", limit: 65535
      end

    end
  end
end
