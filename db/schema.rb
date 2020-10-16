# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_10_193326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "openings", force: :cascade do |t|
    t.string "company_name"
    t.string "job_url"
    t.string "job_title"
    t.string "salary_info"
    t.string "location"
    t.string "job_id"
    t.string "extra_info"
    t.string "company_page"
    t.string "connection"
    t.string "job_description"
    t.string "job_source"
    t.boolean "applied"
    t.boolean "remind_me"
    t.boolean "interested"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
