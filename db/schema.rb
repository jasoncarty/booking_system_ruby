# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_16_202228) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "event_attendees", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "reserve", default: false
    t.index ["event_id"], name: "index_event_attendees_on_event_id"
    t.index ["user_id"], name: "index_event_attendees_on_user_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "url"
    t.datetime "starts_at", precision: nil
    t.datetime "ends_at", precision: nil
    t.string "title"
    t.string "preview"
    t.integer "calendar_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "maximum_event_attendees", default: 0
    t.index ["calendar_id"], name: "index_events_on_calendar_id"
    t.index ["starts_at"], name: "index_events_on_starts_at"
  end

  create_table "site_settings", id: :serial, force: :cascade do |t|
    t.string "site_name"
    t.integer "maximum_event_attendees", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "confirmed"
    t.datetime "confirmed_at", precision: nil
    t.string "verification_token"
    t.datetime "verification_sent_at", precision: nil
    t.string "password_reset_token"
    t.datetime "password_reset_token_sent_at", precision: nil
    t.string "role", default: "user"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

end
