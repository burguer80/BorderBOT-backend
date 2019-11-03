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

ActiveRecord::Schema.define(version: 2019_11_03_002140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "historical_wait_times", force: :cascade do |t|
    t.string "port_number"
    t.integer "month_number"
    t.integer "bwt_day"
    t.integer "time_slot"
    t.integer "cv_time_avg"
    t.integer "xcv_time_avg"
    t.integer "pv_time_avg"
    t.integer "xpv_time_avg"
    t.integer "pv_ready_lanes_time_avg"
    t.integer "ped_time_avg"
    t.integer "ped_ready_lanes_time_avg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bwt_day"], name: "index_historical_wait_times_on_bwt_day"
    t.index ["month_number"], name: "index_historical_wait_times_on_month_number"
    t.index ["port_number"], name: "index_historical_wait_times_on_port_number"
    t.index ["time_slot"], name: "index_historical_wait_times_on_time_slot"
  end

  create_table "holiday_wait_times", force: :cascade do |t|
    t.string "port_number"
    t.datetime "bwt_date"
    t.integer "time_slot"
    t.integer "cv_time"
    t.integer "xcv_time"
    t.integer "pv_time"
    t.integer "xpv_time"
    t.integer "pv_ready_lanes_time"
    t.integer "ped_time"
    t.integer "ped_ready_lanes_time"
    t.datetime "holiday_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bwt_date"], name: "index_holiday_wait_times_on_bwt_date"
    t.index ["holiday_date"], name: "index_holiday_wait_times_on_holiday_date"
    t.index ["port_number"], name: "index_holiday_wait_times_on_port_number"
    t.index ["time_slot"], name: "index_holiday_wait_times_on_time_slot"
  end

  create_table "port_details", id: :integer, default: -> { "nextval('ports_infos_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "number"
    t.jsonb "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["details"], name: "index_ports_infos_on_details", using: :gin
  end

  create_table "ports", id: :serial, force: :cascade do |t|
    t.datetime "taken_at"
    t.string "status"
    t.jsonb "data"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data"], name: "index_ports_on_data", using: :gin
    t.index ["number"], name: "index_ports_on_number"
    t.index ["taken_at", "number"], name: "index_ports_on_taken_at_and_number"
  end

end
