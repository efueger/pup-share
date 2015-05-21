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

ActiveRecord::Schema.define(version: 20150521155442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.string   "name"
    t.string   "walker_sitter"
    t.datetime "available_from"
    t.string   "available_location"
    t.datetime "available_to"
    t.string   "dog_size"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.string   "job_type"
    t.datetime "drop_off_time"
    t.string   "drop_off_location"
    t.datetime "pick_up_time"
    t.string   "pick_up_location"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "building"
    t.string   "address"
    t.string   "phone"
    t.string   "emergency_phone"
    t.boolean  "pup_parent"
    t.boolean  "pup_provider"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "people", ["email"], name: "index_people_on_email", unique: true, using: :btree
  add_index "people", ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true, using: :btree

  create_table "pups", force: :cascade do |t|
    t.string   "name"
    t.string   "breed"
    t.integer  "weight"
    t.string   "gender"
    t.datetime "birthday"
    t.string   "picture"
    t.boolean  "tracking_chip"
    t.boolean  "neutered"
    t.boolean  "good_w_dogs"
    t.text     "special_requirements"
    t.text     "care_instructions"
    t.string   "vet_phone"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
