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

ActiveRecord::Schema.define(version: 20160527145301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

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
    t.integer  "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
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
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "church_id"
    t.integer  "status"
    t.string   "run"
    t.string   "last_name"
    t.string   "middle_name"
    t.boolean  "sexo"
    t.string   "city"
    t.string   "country"
    t.datetime "birthdate"
    t.text     "testimony"
    t.datetime "baptismdate"
    t.datetime "membershipdate"
    t.datetime "disciplinedate"
    t.datetime "transferdate"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "skype"
    t.index ["church_id"], name: "index_members_on_church_id", using: :btree
    t.index ["status"], name: "index_members_on_status", using: :btree
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

  add_foreign_key "families", "churches"
  add_foreign_key "ministries", "churches"
end
