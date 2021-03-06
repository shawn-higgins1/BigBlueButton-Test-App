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

ActiveRecord::Schema.define(version: 2019_05_13_160756) do

  create_table "moderators", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.string "meeting_id"
    t.string "moderatorPw"
    t.string "attendeePw"
    t.text "welcomeMSG"
    t.string "dialNum"
    t.string "logoutURL"
    t.integer "maxParticipants"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
