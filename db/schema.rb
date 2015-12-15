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

ActiveRecord::Schema.define(version: 20151215204704) do

  create_table "base_stocks", force: :cascade do |t|
    t.string   "ticker"
    t.string   "name"
    t.float    "current_market_price"
    t.float    "current_bid_price"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "starting_total"
    t.integer  "max_size"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string   "action"
    t.float    "return_amount"
    t.datetime "trade_time"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "owned_stocks", force: :cascade do |t|
    t.float    "buy_price"
    t.integer  "quantity"
    t.datetime "buy_date"
    t.integer  "portfolio_id"
    t.integer  "base_stock_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.float    "current_value"
    t.integer  "group_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.float    "cash"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
