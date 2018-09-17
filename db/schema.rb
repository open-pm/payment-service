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

ActiveRecord::Schema.define(version: 2018_09_17_071204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.integer "number"
    t.string "zip_code"
    t.string "complement"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_addresses_on_owner_id"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.string "account_number"
    t.string "account_digit"
    t.integer "bank_code"
    t.string "branch_number"
    t.string "branch_digit"
    t.bigint "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_bank_accounts_on_recipient_id"
  end

  create_table "contact_infos", force: :cascade do |t|
    t.string "contact_type"
    t.string "info"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_contact_infos_on_owner_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "number"
    t.string "document_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_documents_on_owner_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "legal_name"
    t.string "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipients", force: :cascade do |t|
    t.string "remote_id"
    t.string "provider_name"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_recipients_on_owner_id"
  end

  add_foreign_key "addresses", "owners"
  add_foreign_key "bank_accounts", "recipients"
  add_foreign_key "contact_infos", "owners"
  add_foreign_key "documents", "owners"
  add_foreign_key "recipients", "owners"
end
