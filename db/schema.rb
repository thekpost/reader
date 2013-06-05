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

ActiveRecord::Schema.define(:version => 20130605002801) do

  create_table "app_keys", :force => true do |t|
    t.integer  "user_id"
    t.string   "app"
    t.text     "app_url"
    t.text     "app_api_token"
    t.string   "app_username"
    t.string   "app_password"
    t.string   "entity_name"
    t.datetime "last_processed"
    t.datetime "last_requested_processing"
    t.string   "is_pending"
    t.integer  "last_request_user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.text     "error_message"
    t.text     "app_account_name"
    t.integer  "dashboard_id"
    t.string   "range"
    t.string   "genre"
    t.boolean  "is_advertisement"
    t.datetime "rss_last_modified_at"
    t.text     "categories"
    t.text     "html_url"
    t.string   "sort_id"
    t.text     "favicon"
    t.string   "colour"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.text     "raw_info"
    t.string   "provider"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.string   "uid"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "dashboards", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
    t.string   "genre"
  end

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

  create_table "feed_entries", :force => true do |t|
    t.integer  "app_key_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "summary"
    t.text     "url"
    t.datetime "published_at"
    t.string   "guid"
    t.boolean  "is_star"
    t.boolean  "is_to_read"
    t.datetime "last_clicked_on"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "categories"
    t.string   "author"
    t.text     "content"
  end

  create_table "tag_entries", :force => true do |t|
    t.integer  "app_key_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "sort_id"
    t.integer  "sort_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "unconfirmed_email"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "is_organization"
    t.string   "plan_genre"
    t.string   "name"
    t.boolean  "is_paying_customer"
    t.string   "username"
    t.string   "slug"
    t.text     "description"
  end

end
