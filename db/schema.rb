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

ActiveRecord::Schema.define(version: 20160629195453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.date     "date"
    t.float    "value",       default: 10.0,  null: false
    t.float    "field_value", default: 150.0, null: false
    t.boolean  "finished",    default: false, null: false
    t.boolean  "video",       default: false, null: false
    t.string   "video_link"
    t.string   "sumula_link"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presences", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "match_id"
    t.boolean  "confirmation", default: false, null: false
    t.boolean  "presence",     default: false, null: false
    t.boolean  "fault",        default: false, null: false
    t.boolean  "payed",        default: false, null: false
    t.integer  "goals",        default: 0,     null: false
    t.integer  "team_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "presences", ["match_id"], name: "index_presences_on_match_id", using: :btree
  add_index "presences", ["player_id"], name: "index_presences_on_player_id", using: :btree
  add_index "presences", ["team_id"], name: "index_presences_on_team_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "color",      null: false
    t.string   "rgb",        null: false
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "presences", "matches"
  add_foreign_key "presences", "players"
  add_foreign_key "presences", "teams"
end
