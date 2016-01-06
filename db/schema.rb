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

ActiveRecord::Schema.define(version: 20160106171248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.integer "game_id",   null: false
    t.integer "player_id", null: false
    t.integer "x",         null: false
    t.integer "y",         null: false
    t.string  "face",      null: false
  end

  add_index "boards", ["game_id", "player_id"], name: "index_boards_on_game_id_and_player_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer "player_ids", null: false, array: true
    t.integer "winners",                 array: true
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
  end

end
