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

ActiveRecord::Schema.define(version: 20140501081848) do

  create_table "cutoffs", force: true do |t|
    t.text     "notes"
    t.date     "date_from"
    t.date     "date_to"
    t.integer  "year_from"
    t.integer  "month_from"
    t.decimal  "budget",     precision: 10, scale: 2, default: 0.0
    t.decimal  "savings",    precision: 10, scale: 2, default: 0.0
    t.decimal  "expenses",   precision: 10, scale: 2, default: 0.0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cutoffs", ["user_id"], name: "index_cutoffs_on_user_id", using: :btree

  create_table "daily_records", force: true do |t|
    t.text     "notes"
    t.date     "transaction_date"
    t.decimal  "budget",           precision: 10, scale: 2, default: 0.0
    t.decimal  "expenses",         precision: 10, scale: 2, default: 0.0
    t.integer  "cutoff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "daily_records", ["cutoff_id"], name: "index_daily_records_on_cutoff_id", using: :btree

  create_table "line_items", force: true do |t|
    t.text     "description",     default: "0"
    t.decimal  "amount"
    t.integer  "daily_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
