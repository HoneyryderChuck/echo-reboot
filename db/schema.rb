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

ActiveRecord::Schema.define(:version => 20130307135302) do

  create_table "background_infos", :force => true do |t|
    t.integer "statement_id",   :null => false
    t.string  "statement_type", :null => false
  end

  create_table "contra_argument_alternatives", :force => true do |t|
    t.integer "contra_arguments_id"
    t.integer "alternative_id"
  end

  create_table "contra_arguments", :force => true do |t|
    t.integer "proposal_id", :null => false
  end

  create_table "follow_up_questions", :force => true do |t|
    t.integer "statement_id",   :null => false
    t.string  "statement_type", :null => false
  end

  create_table "improvement_alternatives", :force => true do |t|
    t.integer "improvement_id"
    t.integer "alternative_id"
  end

  create_table "improvements", :force => true do |t|
    t.integer "proposal_id", :null => false
  end

  create_table "pro_argument_alternatives", :force => true do |t|
    t.integer "pro_argument_id"
    t.integer "alternative_id"
  end

  create_table "pro_arguments", :force => true do |t|
    t.integer "proposal_id", :null => false
  end

  create_table "proposal_alternatives", :force => true do |t|
    t.integer "proposal_id"
    t.integer "alternative_id"
  end

  create_table "proposals", :force => true do |t|
    t.integer "question_id", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer "follow_up_question_id"
  end

end
