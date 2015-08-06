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

ActiveRecord::Schema.define(version: 20150805012939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.datetime "available_from"
    t.datetime "available_to"
    t.text     "location"
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "pup_id"
    t.integer  "job_id"
    t.string   "walk_type"
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
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "jobs", force: :cascade do |t|
    t.datetime "drop_off_time"
    t.string   "drop_off_location"
    t.datetime "pick_up_time"
    t.string   "pick_up_location"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "user_id"
    t.integer  "pup_id"
    t.integer  "availability_id"
    t.boolean  "hidden",            default: false
    t.string   "how_did_it_go"
    t.string   "status"
    t.integer  "actual_walker_id"
    t.integer  "walk_duration"
  end

  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "pups", force: :cascade do |t|
    t.string   "pup_name"
    t.string   "pup_breed"
    t.string   "pup_weight"
    t.string   "pup_gender"
    t.string   "pup_vet_phone"
    t.text     "pup_care_instructions"
    t.integer  "pup_age"
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "pup_pic"
    t.boolean  "special_needs"
    t.boolean  "spayed_neutered"
    t.boolean  "hidden",                default: false
    t.integer  "walks_completed",       default: 0
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "requested_of_user_id"
    t.string   "status"
    t.integer  "job_id"
    t.integer  "availability_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "hidden",               default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "building"
    t.string   "address"
    t.string   "phone"
    t.string   "emergency_phone"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "email",                       default: "",    null: false
    t.string   "encrypted_password",          default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "user_pending_requests_count", default: 0
    t.string   "pic"
    t.boolean  "pups_w_special_needs"
    t.text     "walking_experience"
    t.boolean  "small_pups"
    t.boolean  "medium_pups"
    t.boolean  "large_pups"
    t.boolean  "giant_pups"
    t.boolean  "oral_med_admin"
    t.boolean  "senior_pups"
    t.boolean  "puppies"
    t.boolean  "bathroom_breaks"
    t.boolean  "hidden",                      default: false
    t.integer  "awesome_count",               default: 0
    t.integer  "not_good_count",              default: 0
    t.integer  "no_show_count",               default: 0
    t.integer  "walks_completed",             default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
