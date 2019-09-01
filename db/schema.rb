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

ActiveRecord::Schema.define(version: 2019_08_31_193458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aliases", force: :cascade do |t|
    t.string "alt"
    t.string "object_type"
    t.bigint "object_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
  end

  create_table "characters_games", id: false, force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "game_id", null: false
  end

  create_table "characters_match_players", id: false, force: :cascade do |t|
    t.bigint "match_player_id", null: false
    t.bigint "character_id", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.date "release_date"
  end

  create_table "match_players", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "match_id"
    t.integer "team_id"
    t.index ["match_id"], name: "index_match_players_on_match_id"
    t.index ["player_id"], name: "index_match_players_on_player_id"
  end

  create_table "match_types", force: :cascade do |t|
    t.string "name"
    t.integer "player_count", default: 2
    t.integer "team_count", default: 2
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "tournament_id"
    t.bigint "match_type_id"
    t.bigint "video_id"
    t.index ["match_type_id"], name: "index_matches_on_match_type_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
    t.index ["video_id"], name: "index_matches_on_video_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "gamertag"
    t.string "sponsor"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.string "channel_id"
    t.boolean "collection_active", default: true
  end

  create_table "title_regexes", force: :cascade do |t|
    t.string "regex_string"
    t.bigint "game_id"
    t.bigint "match_type_id"
    t.bigint "source_id"
    t.index ["game_id"], name: "index_title_regexes_on_game_id"
    t.index ["match_type_id"], name: "index_title_regexes_on_match_type_id"
    t.index ["source_id"], name: "index_title_regexes_on_source_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title", null: false
    t.string "url", null: false
    t.date "upload_date"
    t.bigint "view_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_id"
    t.string "video_id", null: false
    t.index ["source_id"], name: "index_videos_on_source_id"
  end

  add_foreign_key "matches", "tournaments"
  add_foreign_key "videos", "sources"
end
