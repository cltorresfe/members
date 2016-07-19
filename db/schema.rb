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

ActiveRecord::Schema.define(version: 20160719192217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "ministry_id"
    t.datetime "attendance_date"
    t.boolean  "present"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["member_id"], name: "index_attendances_on_member_id", using: :btree
    t.index ["ministry_id"], name: "index_attendances_on_ministry_id", using: :btree
  end

  create_table "charge_members", force: :cascade do |t|
    t.integer  "charge_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["charge_id"], name: "index_charge_members_on_charge_id", using: :btree
    t.index ["member_id"], name: "index_charge_members_on_member_id", using: :btree
  end

  create_table "charges", force: :cascade do |t|
    t.integer  "ministry_id"
    t.integer  "responsibility_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["ministry_id"], name: "index_charges_on_ministry_id", using: :btree
    t.index ["responsibility_id"], name: "index_charges_on_responsibility_id", using: :btree
  end

  create_table "churches", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "families", force: :cascade do |t|
    t.string   "name"
    t.datetime "married_at"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.string   "country"
    t.integer  "church_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["church_id"], name: "index_families_on_church_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "church_id"
    t.integer  "status"
    t.string   "run"
    t.string   "last_name"
    t.boolean  "gender"
    t.string   "city"
    t.string   "country"
    t.text     "testimony"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "skype"
    t.datetime "birth_date"
    t.datetime "baptism_date"
    t.datetime "membership_date"
    t.datetime "discipline_date"
    t.datetime "transfer_date"
    t.string   "avatar"
    t.integer  "role"
    t.integer  "family_id"
    t.index ["church_id"], name: "index_members_on_church_id", using: :btree
    t.index ["family_id"], name: "index_members_on_family_id", using: :btree
  end

  create_table "members_responsibilities", id: false, force: :cascade do |t|
    t.integer "member_id"
    t.integer "responsibility_id"
    t.index ["member_id"], name: "index_members_responsibilities_on_member_id", using: :btree
    t.index ["responsibility_id"], name: "index_members_responsibilities_on_responsibility_id", using: :btree
  end

  create_table "ministries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "church_id"
    t.index ["church_id"], name: "index_ministries_on_church_id", using: :btree
  end

  create_table "responsibilities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "administrative", default: false
    t.integer  "church_id"
    t.index ["church_id"], name: "index_responsibilities_on_church_id", using: :btree
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
    t.integer  "church_id"
    t.integer  "role"
    t.index ["church_id"], name: "index_users_on_church_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "attendances", "members"
  add_foreign_key "attendances", "ministries"
  add_foreign_key "charge_members", "charges"
  add_foreign_key "charge_members", "members"
  add_foreign_key "charges", "ministries"
  add_foreign_key "charges", "responsibilities"
  add_foreign_key "families", "churches"
  add_foreign_key "members", "churches"
  add_foreign_key "members", "families"
  add_foreign_key "ministries", "churches"
  add_foreign_key "responsibilities", "churches"
  add_foreign_key "users", "churches"
end
