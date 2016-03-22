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

ActiveRecord::Schema.define(version: 20160320175358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "daily_reports", force: true do |t|
    t.date     "date"
    t.integer  "project_id"
    t.string   "project_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "complete"
  end

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manifest_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "truck_id"
    t.time     "time_in"
    t.time     "time_out"
    t.integer  "manifest_number"
    t.string   "cell"
    t.string   "facility_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plate"
    t.integer  "truck_number"
    t.string   "company"
    t.date     "date"
    t.integer  "facility_id"
    t.string   "project_name"
    t.integer  "project_id"
    t.integer  "daily_report_id"
    t.text     "comment"
    t.boolean  "final_load"
  end

  create_table "permissions", force: true do |t|
    t.boolean  "admin?"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trucks", force: true do |t|
    t.string   "plate"
    t.integer  "company_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_name"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
