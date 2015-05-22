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

ActiveRecord::Schema.define(version: 20150522154654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string   "name"
    t.string   "job_type"
    t.datetime "drop_off_time"
    t.string   "drop_off_location"
    t.datetime "pick_up_time"
    t.string   "pick_up_location"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "person_id"
  end

  add_index "jobs", ["person_id"], name: "index_jobs_on_person_id", using: :btree

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
    t.integer  "job_id"
    t.integer  "user_id"
  end

  add_index "pups", ["job_id"], name: "index_pups_on_job_id", using: :btree
  add_index "pups", ["user_id"], name: "index_pups_on_user_id", using: :btree

  create_table "pups_jobs", id: false, force: :cascade do |t|
    t.integer "pup_id"
    t.integer "job_id"
  end

  add_index "pups_jobs", ["job_id"], name: "index_pups_jobs_on_job_id", using: :btree
  add_index "pups_jobs", ["pup_id"], name: "index_pups_jobs_on_pup_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "building"
    t.string   "address"
    t.string   "phone"
    t.string   "emergency_phone"
    t.boolean  "parent"
    t.boolean  "walker"
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

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
