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

ActiveRecord::Schema.define(version: 20160128044057) do

  create_table "user_data", force: :cascade do |t|
    t.boolean  "consent"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "basic_complete"
    t.boolean  "diabetes_complete"
    t.boolean  "physical_complete"
    t.boolean  "alcohol_complete"
    t.boolean  "returning_user"
    t.integer  "returning_user_q1a"
    t.integer  "returning_user_q1b"
    t.integer  "returning_user_q1c"
    t.integer  "returning_user_q1d"
    t.integer  "returning_user_q1e"
    t.string   "returning_user_q2"
    t.string   "returning_user_q3"
    t.string   "returning_user_q4"
    t.boolean  "returning_user_q5"
    t.string   "full_name"
    t.date     "date_of_birth"
    t.integer  "gender"
    t.string   "suburb"
    t.integer  "country_of_birth"
    t.boolean  "aboriginal"
    t.integer  "has_diabetes"
    t.integer  "smoking"
    t.string   "allergies"
    t.string   "other_allergies"
    t.decimal  "weight"
    t.decimal  "height"
    t.decimal  "bmi"
    t.datetime "bmi_recorded_at"
    t.integer  "alcohol_frequency"
    t.integer  "alcohol_num_drinks"
    t.integer  "alcohol_frequency_six_or_more"
    t.integer  "alcohol_score"
    t.integer  "physical_work_type"
    t.integer  "physical_activity_exercise"
    t.integer  "physical_activity_cycling"
    t.integer  "physical_activity_walking"
    t.integer  "physical_activity_housework"
    t.integer  "physical_activity_gardening"
    t.integer  "physical_walking_pace"
    t.integer  "physical_score"
    t.integer  "diabetes_age_group"
    t.boolean  "diabetes_hereditary"
    t.boolean  "diabetes_high_blood_glucose"
    t.boolean  "diabetes_hbp_medication"
    t.integer  "diabetes_fruit_and_veg"
    t.boolean  "diabetes_physical_activity"
    t.integer  "diabetes_waist_measurement"
    t.integer  "diabetes_score"
  end

end
