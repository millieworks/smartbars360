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

ActiveRecord::Schema.define(:version => 20121031111438) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "api_key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customers", ["api_key"], :name => "index_customers_on_api_key", :unique => true

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "rule_types", :force => true do |t|
    t.string   "name"
    t.string   "indicator"
    t.string   "value_label"
    t.string   "value_operator"
    t.string   "default_value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "rules", :force => true do |t|
    t.integer  "smartbar_id"
    t.integer  "rule_type_id"
    t.string   "value"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "rules", ["rule_type_id", "smartbar_id"], :name => "index_rules_on_rule_type_id_and_smartbar_id"
  add_index "rules", ["smartbar_id", "rule_type_id"], :name => "index_rules_on_smartbar_id_and_rule_type_id"

  create_table "smartbar_content_templates", :force => true do |t|
    t.string   "name"
    t.text     "html"
    t.text     "css"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "smartbar_format_templates", :force => true do |t|
    t.string   "name"
    t.text     "html"
    t.text     "css"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "smartbars", :force => true do |t|
    t.string   "name"
    t.integer  "customer_id"
    t.string   "url"
    t.string   "url_regex"
    t.text     "html"
    t.text     "minified_html"
    t.text     "css"
    t.text     "minified_css"
    t.string   "position_element", :default => "body"
    t.boolean  "position_prepend", :default => true
    t.string   "callback_url"
    t.string   "status"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "rule_grouping",    :default => "and"
  end

  add_index "smartbars", ["customer_id"], :name => "index_smartbars_on_customer_id"
  add_index "smartbars", ["url"], :name => "index_smartbars_on_url"

  create_table "tracked_urls", :force => true do |t|
    t.string   "tracked_user_id"
    t.string   "customer_id"
    t.string   "ip_address"
    t.string   "scheme"
    t.string   "host"
    t.string   "port"
    t.string   "path"
    t.string   "query"
    t.datetime "tracked_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "tracked_urls", ["customer_id"], :name => "index_tracked_urls_on_customer_id"
  add_index "tracked_urls", ["tracked_at"], :name => "index_tracked_urls_on_tracked_at"
  add_index "tracked_urls", ["tracked_user_id"], :name => "index_tracked_urls_on_tracked_user_id"

  create_table "tracked_user_actions", :force => true do |t|
    t.integer  "tracked_user_id"
    t.integer  "smartbar_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "data"
  end

  add_index "tracked_user_actions", ["smartbar_id", "tracked_user_id"], :name => "index_tracked_user_actions_on_smartbar_id_and_tracked_user_id"
  add_index "tracked_user_actions", ["tracked_user_id", "smartbar_id"], :name => "index_tracked_user_actions_on_tracked_user_id_and_smartbar_id"

  create_table "tracked_users", :force => true do |t|
    t.string   "public_user_id"
    t.integer  "customer_id"
    t.integer  "page_impressions", :default => 0
    t.integer  "visits",           :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "tracked_users", ["customer_id"], :name => "index_tracked_users_on_customer_id"
  add_index "tracked_users", ["public_user_id"], :name => "index_tracked_users_on_public_user_id", :unique => true

  create_table "users", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "customer_id"
  end

  add_index "users", ["customer_id"], :name => "index_users_on_customer_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
