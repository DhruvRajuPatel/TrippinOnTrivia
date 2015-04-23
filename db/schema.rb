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

ActiveRecord::Schema.define(version: 20150423030100) do

  create_table "achievements", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.string   "uid"
    t.string   "title"
  end

  create_table "achievements_users", id: false, force: :cascade do |t|
    t.integer "achievement_id"
    t.string  "uid"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",              default: "",    null: false
    t.string   "encrypted_password", default: "",    null: false
    t.integer  "sign_in_count",      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reviewer",           default: false, null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true

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
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "question_id"
    t.integer  "player_id"
    t.integer  "achievement_id"
    t.integer  "category_correct_counter_id"
  end

  add_index "categories", ["question_id"], name: "index_categories_on_question_id"

  create_table "categories_category_correct_counters", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "category_correct_counter_id"
  end

  create_table "category_correct_counters", force: :cascade do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "uid"
    t.integer  "category_id"
    t.integer  "questions_correct",     default: 0, null: false
    t.integer  "aquatic_counter_id"
    t.integer  "memes_counter_id"
    t.integer  "basketball_counter_id"
    t.integer  "literature_counter_id"
    t.integer  "music_counter_id"
    t.integer  "cs_counter_id"
  end

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
    t.boolean  "is_first_round"
  end

  create_table "challenges_players", id: false, force: :cascade do |t|
    t.integer "challenge_id"
    t.integer "player_id"
  end

  create_table "challenges_questions", id: false, force: :cascade do |t|
    t.integer "challenge_id"
    t.integer "question_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.integer  "meter"
    t.boolean  "is_current_turn"
    t.integer  "player_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
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
    t.boolean  "has_won",              default: false
    t.boolean  "is_inactive",          default: false
    t.integer  "current_category_id"
    t.integer  "current_question_id"
    t.integer  "current_answer_id"
  end

  add_index "players", ["uid"], name: "index_players_on_uid"

  create_table "players_trophies", id: false, force: :cascade do |t|
    t.integer "player_id"
    t.integer "trophy_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "rating"
    t.boolean  "user_submitted",            default: false, null: false
    t.integer  "category_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "answer_id"
    t.integer  "player_id"
    t.integer  "challenge_id"
    t.float    "times_rated",               default: 1.0,   null: false
    t.float    "average_difficulty_rating", default: 0.0,   null: false
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
    t.string   "email",                       default: "",    null: false
    t.string   "encrypted_password",          default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",               default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.integer  "player_id"
    t.integer  "points",                      default: 0,     null: false
    t.integer  "level",                       default: 1,     null: false
    t.integer  "total_correct",               default: 0,     null: false
    t.string   "achievement_id"
    t.integer  "category_correct_counter_id"
    t.integer  "aquatic_counter_id"
    t.integer  "memes_counter_id"
    t.integer  "basketball_counter_id"
    t.integer  "literature_counter_id"
    t.integer  "music_counter_id"
    t.integer  "cs_counter_id"
    t.boolean  "has_new_achievement",         default: false, null: false
    t.integer  "win_count",                   default: 0
    t.boolean  "muted",                       default: false, null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "hide_image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
