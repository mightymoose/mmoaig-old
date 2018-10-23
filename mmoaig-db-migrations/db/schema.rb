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

ActiveRecord::Schema.define(version: 2018_10_20_181712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bots", primary_key: "bot_id", force: :cascade do |t|
    t.integer "bot_github_repository_id__github_repository_id"
    t.string "bot_path"
  end

  create_table "github_repositories", primary_key: "github_repository_id", force: :cascade do |t|
    t.string "github_repository_name", null: false
    t.integer "github_repository_github_user_id__github_user_id", null: false
  end

  create_table "github_users", primary_key: "github_user_id", force: :cascade do |t|
    t.string "github_user_username", null: false
    t.integer "github_user_user_id__user_id", null: false
  end

  create_table "match_instances", primary_key: "match_instance_id", force: :cascade do |t|
    t.string "match_instance_token", null: false
    t.integer "match_instance_match_id__match_id", null: false
  end

  create_table "match_participation", primary_key: "match_participation_id", force: :cascade do |t|
    t.integer "match_participation_bot_id__bot_id"
    t.integer "match_participation_match_id__match_id"
  end

  create_table "matches", primary_key: "match_id", force: :cascade do |t|
    t.string "match_status"
    t.string "match_type"
    t.integer "match_most_recent_instance__match_instance_id"
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "user_username", null: false
    t.boolean "user_active", null: false
  end

end
