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

ActiveRecord::Schema.define(version: 20140624091726) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "group_reporters", force: true do |t|
    t.integer  "group_id"
    t.integer  "reporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_reporters", ["group_id"], name: "index_group_reporters_on_group_id", using: :btree
  add_index "group_reporters", ["reporter_id"], name: "index_group_reporters_on_reporter_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: true do |t|
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["resource_type", "resource_id"], name: "index_options_on_resource_type_and_resource_id", using: :btree

  create_table "plugins", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reporters", force: true do |t|
    t.string   "name"
    t.string   "plugin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_reporters", force: true do |t|
    t.integer  "service_id"
    t.integer  "reporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_reporters", ["reporter_id"], name: "index_service_reporters_on_reporter_id", using: :btree
  add_index "service_reporters", ["service_id"], name: "index_service_reporters_on_service_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "plugin"
    t.integer  "timeout"
    t.datetime "last_run_at"
    t.integer  "group_id"
    t.boolean  "failed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["group_id"], name: "index_services_on_group_id", using: :btree

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
