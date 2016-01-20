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

ActiveRecord::Schema.define(version: 20160120215102) do

  create_table "albums", force: :cascade do |t|
    t.string   "title"
    t.datetime "released"
    t.integer  "band_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums_songs", id: false, force: :cascade do |t|
    t.integer "album_id"
    t.integer "song_id"
  end

  add_index "albums_songs", ["album_id"], name: "index_albums_songs_on_album_id"
  add_index "albums_songs", ["song_id"], name: "index_albums_songs_on_song_id"

  create_table "band_roles", force: :cascade do |t|
    t.string  "role",    null: false
    t.integer "band_id"
    t.integer "user_id"
  end

  add_index "band_roles", ["band_id"], name: "index_band_roles_on_band_id"
  add_index "band_roles", ["user_id"], name: "index_band_roles_on_user_id"

  create_table "bands", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bands_genres", id: false, force: :cascade do |t|
    t.integer "band_id"
    t.integer "genre_id"
  end

  add_index "bands_genres", ["band_id"], name: "index_bands_genres_on_band_id"
  add_index "bands_genres", ["genre_id"], name: "index_bands_genres_on_genre_id"

  create_table "bands_users", id: false, force: :cascade do |t|
    t.integer "band_id"
    t.integer "user_id"
  end

  add_index "bands_users", ["band_id"], name: "index_bands_users_on_band_id"
  add_index "bands_users", ["user_id"], name: "index_bands_users_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concerts", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "title",      null: false
    t.string   "location",   null: false
    t.integer  "capacity"
    t.datetime "from_date"
    t.datetime "to_date"
    t.decimal  "price",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "genres", ["title"], name: "index_genres_on_title", unique: true

  create_table "performers", force: :cascade do |t|
    t.integer "concert_id"
    t.integer "band_id"
    t.boolean "confirmed"
  end

  add_index "performers", ["band_id"], name: "index_performers_on_band_id"
  add_index "performers", ["concert_id"], name: "index_performers_on_concert_id"

  create_table "songs", force: :cascade do |t|
    t.string   "title"
    t.string   "lyrics"
    t.integer  "band_id"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
