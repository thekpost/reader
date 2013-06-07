class AddCols < ActiveRecord::Migration
  def change

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
end
