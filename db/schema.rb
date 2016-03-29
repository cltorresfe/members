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

ActiveRecord::Schema.define(version: 20160328005334) do

  create_table "churches", force: :cascade do |t|
    t.string   "name"
    t.string   "adress"
    t.string   "email"
    t.integer  "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "adress"
    t.string   "email"
    t.integer  "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "church_id"
    t.integer  "status_id"
  end

  add_index "members", ["church_id"], name: "index_members_on_church_id"
  add_index "members", ["status_id"], name: "index_members_on_status_id"

  create_table "members_responsibilities", id: false, force: :cascade do |t|
    t.integer "member_id"
    t.integer "responsibility_id"
  end

  add_index "members_responsibilities", ["member_id"], name: "index_members_responsibilities_on_member_id"
  add_index "members_responsibilities", ["responsibility_id"], name: "index_members_responsibilities_on_responsibility_id"

  create_table "responsibilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
