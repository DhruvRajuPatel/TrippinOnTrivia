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

ActiveRecord::Schema.define(version: 20150410083438) do

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "answers", force: :cascade do |t|
    t.string   "title"
    t.boolean  "is_correct"
    t.integer  "question_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "player_id"
    t.integer  "challenge_id"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.integer  "player_id"
  end

  add_index "categories", ["question_id"], name: "index_categories_on_question_id"

  create_table "challenges", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "question_counter"
    t.integer  "challenger_player_id"
    t.integer  "challenged_player_id"
    t.integer  "winner_player_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "player_id"
    t.integer  "challenger_score"
    t.integer  "challenged_score"
    t.integer  "trophy_id"
    t.integer  "challenged_trophy_id"
    t.integer  "bid_trophy_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "meter"
    t.boolean  "isActivePlayer"
    t.integer  "player_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "uid"
    t.integer  "active_player_id"
    t.boolean  "going_for_trophy"
    t.integer  "category_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "challenger_player_id"
    t.integer  "challenged_player_id"
    t.integer  "challenge_id"
    t.integer  "challenge_score"
  end

  add_index "players", ["uid"], name: "index_players_on_uid"

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "rating"
    t.integer  "category_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "answer_id"
    t.integer  "player_id"
    t.integer  "challenge_id"
  end

  add_index "questions", ["answer_id"], name: "index_questions_on_answer_id"
  add_index "questions", ["category_id"], name: "index_questions_on_category_id"

  create_table "trophies", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "player_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "icon_path"
    t.integer  "challenged_trophy_id"
    t.integer  "bid_trophy_id"
  end

  add_index "trophies", ["category_id"], name: "index_trophies_on_category_id"
  add_index "trophies", ["player_id"], name: "index_trophies_on_player_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "player_id"
    t.integer  "level"
    t.integer  "total_correct"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
