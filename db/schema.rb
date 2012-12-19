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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121219145817) do

  create_table "facturation_milks", :force => true do |t|
    t.date     "date"
    t.integer  "liters"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kine", :force => true do |t|
    t.string   "ring"
    t.string   "name"
    t.integer  "num_borns"
    t.string   "father"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.boolean  "is_milk"
    t.integer  "short_ring"
    t.date     "date_down"
    t.date     "date_born"
    t.integer  "is_active"
    t.integer  "is_pregnant"
    t.date     "last_failed_insemination"
  end

  create_table "lactations", :force => true do |t|
    t.integer  "greasy_kg"
    t.integer  "protein_kg"
    t.float    "greasy_percentage"
    t.float    "protein_percentage"
    t.integer  "cell"
    t.date     "date"
    t.integer  "lactation_duration"
    t.integer  "milk_kg"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "year"
    t.integer  "cow_id"
  end

  create_table "reproduction_simbols", :force => true do |t|
    t.string   "simbol"
    t.string   "meaning"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reproductions", :force => true do |t|
    t.integer  "cow_id"
    t.integer  "reproduction_simbol_id"
    t.integer  "year"
    t.integer  "month"
    t.string   "comment"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "bull"
    t.date     "date"
  end

end
