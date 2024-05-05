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

ActiveRecord::Schema[7.0].define(version: 2024_05_02_233420) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exchanges", force: :cascade do |t|
    t.bigint "exchange_event_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "recipient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_event_id"], name: "index_exchanges_on_exchange_event_id"
    t.index ["recipient_id"], name: "index_exchanges_on_recipient_id"
    t.index ["sender_id"], name: "index_exchanges_on_sender_id"
  end

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id", null: false
    t.index ["family_id"], name: "index_members_on_family_id"
  end

  add_foreign_key "exchanges", "exchange_events"
  add_foreign_key "exchanges", "members", column: "recipient_id"
  add_foreign_key "exchanges", "members", column: "sender_id"
  add_foreign_key "members", "families"
end
