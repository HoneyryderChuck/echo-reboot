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

ActiveRecord::Schema.define(:version => 20130316002524) do

  create_table "background_infos", :force => true do |t|
    t.integer  "statement_id",                 :null => false
    t.string   "statement_type",               :null => false
    t.integer  "creator_id"
    t.integer  "node_id"
    t.string   "info_type_code", :limit => 15
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "contra_argument_alternatives", :force => true do |t|
    t.integer "contra_arguments_id"
    t.integer "alternative_id"
  end

  create_table "contra_arguments", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "creator_id"
    t.integer  "node_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "title",                       :limit => 101
    t.text     "text"
    t.text     "language_code",               :limit => 255
    t.text     "action_code",                 :limit => 255
    t.integer  "node_id",                                    :null => false
    t.integer  "author_id",                                  :null => false
    t.integer  "previous_document_id"
    t.integer  "incorporated_statement_id"
    t.string   "incorporated_statement_type"
    t.integer  "locked_by"
    t.datetime "locked_at"
    t.boolean  "current"
  end

  create_table "echos", :force => true do |t|
    t.integer  "echoable_id",                    :null => false
    t.string   "echoable_type",                  :null => false
    t.integer  "visitor_count",   :default => 0
    t.integer  "supporter_count", :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "follow_up_questions", :force => true do |t|
    t.integer  "statement_id",   :null => false
    t.string   "statement_type", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "improvement_alternatives", :force => true do |t|
    t.integer "improvement_id"
    t.integer "alternative_id"
    t.integer "creator_id"
  end

  create_table "improvements", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "creator_id"
    t.integer  "node_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "nodes", :force => true do |t|
    t.string "editorial_state_code", :limit => 15
    t.string "image"
  end

  create_table "pro_argument_alternatives", :force => true do |t|
    t.integer "pro_argument_id"
    t.integer "alternative_id"
  end

  create_table "pro_arguments", :force => true do |t|
    t.integer  "proposal_id", :null => false
    t.integer  "creator_id"
    t.integer  "node_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer "user_id",                    :null => false
    t.string  "avatar"
    t.string  "full_name"
    t.string  "city",       :limit => 50
    t.string  "country",    :limit => 50
    t.string  "about_me",   :limit => 1024
    t.string  "motivation", :limit => 1024
  end

  create_table "proposal_alternatives", :force => true do |t|
    t.integer "proposal_id"
    t.integer "alternative_id"
    t.integer "creator_id"
  end

  create_table "proposals", :force => true do |t|
    t.integer  "question_id", :null => false
    t.integer  "creator_id"
    t.integer  "node_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "follow_up_question_id"
    t.integer  "creator_id"
    t.integer  "node_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "spoken_languages", :force => true do |t|
    t.integer "user_id",                           :null => false
    t.string  "language_code",       :limit => 2
    t.string  "language_level_code", :limit => 20
  end

  create_table "tag_translations", :force => true do |t|
    t.integer "tag_id"
    t.string  "language_code", :limit => 2
    t.string  "value"
  end

  create_table "tags", :force => true do |t|
  end

  create_table "tao_tags", :force => true do |t|
    t.integer "tag_id"
    t.integer "tao_id"
    t.string  "tao_type"
    t.string  "tag_context_code"
  end

  create_table "user_echos", :force => true do |t|
    t.integer  "echo_id",                       :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "visited",    :default => false
    t.boolean  "supported",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
