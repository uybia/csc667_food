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

ActiveRecord::Schema.define(version: 20131125230004) do

  create_table "demos", force: true do |t|
    t.string   "item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", force: true do |t|
    t.string   "name"
    t.integer  "calories"
    t.integer  "sodium"
    t.integer  "totalfat"
    t.integer  "saturated"
    t.integer  "polyunsaturated"
    t.integer  "monosaturated"
    t.integer  "transfat"
    t.integer  "cholesterol"
    t.integer  "potassium"
    t.integer  "carbs"
    t.integer  "fiber"
    t.integer  "sugar"
    t.integer  "protein"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_tables", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testings", force: true do |t|
    t.string   "item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
