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

ActiveRecord::Schema.define(version: 20150605050229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "series", force: :cascade do |t|
    t.string   "title"
    t.string   "photo"
    t.string   "rating"
    t.integer  "length"
    t.string   "years"
    t.string   "recap"
    t.string   "category"
    t.string   "cast"
    t.integer  "like"
    t.integer  "dislike"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category2"
    t.string   "category3"
    t.string   "link"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "like1"
    t.integer  "like2"
    t.integer  "like3"
    t.integer  "like4"
    t.integer  "like5"
    t.integer  "dislike1"
    t.integer  "dislike2"
    t.integer  "dislike3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
