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

ActiveRecord::Schema.define(version: 20161031072358) do

  create_table "sanchaypatras", force: :cascade do |t|
    t.string   "reg_number",         limit: 255
    t.date     "issue_date"
    t.decimal  "amount",                         precision: 10
    t.decimal  "profit_per_lac",                 precision: 10
    t.date     "active_date"
    t.date     "expire_date"
    t.decimal  "profilt_percentage",             precision: 10
    t.integer  "interval_month",     limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.integer  "sanchaypatra_id", limit: 4
    t.integer  "token_number",    limit: 4
    t.date     "token_date"
    t.boolean  "is_redeemed",               default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "tokens", ["sanchaypatra_id"], name: "index_tokens_on_sanchaypatra_id", using: :btree

end
