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

ActiveRecord::Schema.define(:version => 20130420011951) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "attachments", :force => true do |t|
    t.string   "item"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "checklist_items", :force => true do |t|
    t.integer  "checklist_id"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "checklist_items", ["checklist_id"], :name => "index_checklist_items_on_checklist_id"
  add_index "checklist_items", ["name"], :name => "index_checklist_items_on_name"

  create_table "checklists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "author_id"
    t.string   "name"
    t.string   "frequency"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "days_of_week_mask"
    t.integer  "checklist_item_id"
  end

  add_index "checklists", ["author_id"], :name => "index_checklists_on_author_id"
  add_index "checklists", ["name"], :name => "index_checklists_on_name"
  add_index "checklists", ["user_id"], :name => "index_checklists_on_user_id"

  create_table "club_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "club_users", ["user_id", "club_id"], :name => "index_club_users_on_user_id_and_club_id"

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.text     "address"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "abbreviation"
  end

  add_index "clubs", ["name"], :name => "index_clubs_on_name"
  add_index "clubs", ["region_id"], :name => "index_clubs_on_region_id"

  create_table "completes", :force => true do |t|
    t.integer  "completable_id"
    t.string   "completable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "completes", ["completable_id"], :name => "index_completes_on_completable_id"

  create_table "contexts", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "owner_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contexts", ["name"], :name => "index_contexts_on_name"
  add_index "contexts", ["owner_id", "name"], :name => "index_contexts_on_owner_id_and_name"
  add_index "contexts", ["owner_id"], :name => "index_contexts_on_owner_id"

  create_table "daily_summaries", :force => true do |t|
    t.datetime "summary_date"
    t.integer  "monthly_summary_id"
    t.decimal  "membership_cash",                :precision => 8, :scale => 2
    t.decimal  "training_cash",                  :precision => 8, :scale => 2
    t.decimal  "juice_bar_cash",                 :precision => 8, :scale => 2
    t.decimal  "nursery_cash",                   :precision => 8, :scale => 2
    t.decimal  "membership_draft_cash",          :precision => 8, :scale => 2
    t.decimal  "training_draft_cash",            :precision => 8, :scale => 2
    t.integer  "membership_cancellations"
    t.decimal  "membership_cancellations_value", :precision => 8, :scale => 2
    t.integer  "membership_freezes"
    t.decimal  "membership_freezes_value",       :precision => 8, :scale => 2
    t.integer  "membership_delinquents"
    t.decimal  "membership_delinquents_value",   :precision => 8, :scale => 2
    t.integer  "training_cancellations"
    t.decimal  "training_cancellations_value",   :precision => 8, :scale => 2
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "daily_summaries", ["monthly_summary_id"], :name => "index_daily_summaries_on_monthly_summary_id"

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "envelopes", :force => true do |t|
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.boolean  "read_flag",      :default => false
    t.boolean  "important_flag", :default => false
    t.boolean  "trash_flag",     :default => false
    t.boolean  "delete_flag",    :default => false
    t.datetime "delivered_at"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "author_flag",    :default => false
  end

  add_index "envelopes", ["message_id"], :name => "index_envelopes_on_message_id"
  add_index "envelopes", ["recipient_id"], :name => "index_envelopes_on_recipient_id"

  create_table "event_subscriptions", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer "organizer_id"
    t.text    "summary"
    t.text    "description"
    t.time    "starts_at_time"
    t.date    "starts_at_date"
    t.date    "ends_at_date"
    t.integer "days_of_week_mask"
  end

  add_index "events", ["organizer_id"], :name => "index_events_on_organizer_id"
  add_index "events", ["starts_at_date", "starts_at_time"], :name => "index_events_on_starts_at_date_and_starts_at_time"
  add_index "events", ["starts_at_date"], :name => "index_events_on_starts_at_date"

  create_table "events_save", :force => true do |t|
    t.integer  "user_id"
    t.string   "invitee_list"
    t.string   "subject"
    t.string   "location"
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "state"
  end

  add_index "events_save", ["end_at"], :name => "index_events_on_end_at"
  add_index "events_save", ["start_at"], :name => "index_events_on_start_at"
  add_index "events_save", ["user_id"], :name => "index_events_on_user_id"

  create_table "mailboxes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "host"
    t.string   "port"
    t.boolean  "ssl"
    t.string   "domain"
    t.string   "username"
    t.string   "passcode"
    t.boolean  "starttls_auto"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "mailboxes", ["user_id"], :name => "index_mailboxes_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.string   "send_to",              :default => ""
    t.string   "copy_to",              :default => ""
    t.string   "blind_copy_to",        :default => ""
    t.string   "subject"
    t.text     "body"
    t.string   "status",               :default => "draft"
    t.string   "importance",           :default => "normal"
    t.datetime "sent_at"
    t.boolean  "read_receipt_request", :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  add_index "messages", ["author_id"], :name => "index_messages_on_author_id"
  add_index "messages", ["sent_at"], :name => "index_messages_on_sent_at"
  add_index "messages", ["subject"], :name => "index_messages_on_subject"

  create_table "monthly_summaries", :force => true do |t|
    t.integer  "club_id"
    t.datetime "month"
    t.integer  "business_days_in_month"
    t.decimal  "membership_goal",           :precision => 8, :scale => 2
    t.decimal  "training_goal",             :precision => 8, :scale => 2
    t.decimal  "juice_bar_goal",            :precision => 8, :scale => 2
    t.decimal  "nursery_goal",              :precision => 8, :scale => 2
    t.decimal  "membership_draft_expected", :precision => 8, :scale => 2
    t.decimal  "training_draft_expected",   :precision => 8, :scale => 2
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "monthly_summaries", ["club_id"], :name => "index_monthly_summaries_on_club_id"
  add_index "monthly_summaries", ["month"], :name => "index_monthly_summaries_on_month"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "owner_id"
    t.integer  "position"
    t.integer  "context_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["owner_id", "name"], :name => "index_projects_on_owner_id_and_name"
  add_index "projects", ["owner_id"], :name => "index_projects_on_owner_id"

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sys_logs", :force => true do |t|
    t.text     "message"
    t.string   "message_type"
    t.string   "actioned_by"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "sys_logs", ["loggable_id", "loggable_type"], :name => "index_sys_logs_on_loggable_id_and_loggable_type"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.datetime "due_at"
    t.datetime "completed_at"
    t.integer  "context_id"
    t.integer  "project_id"
    t.integer  "owner_id"
    t.text     "notes"
    t.string   "state"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "assignee_id"
    t.datetime "started_at"
    t.datetime "claimed_at"
    t.integer  "priority"
    t.integer  "department_id"
  end

  add_index "tasks", ["assignee_id", "due_at"], :name => "index_tasks_on_assignee_id_and_due_at"
  add_index "tasks", ["assignee_id"], :name => "index_tasks_on_assignee_id"
  add_index "tasks", ["context_id"], :name => "index_tasks_on_context_id"
  add_index "tasks", ["owner_id"], :name => "index_tasks_on_owner_id"
  add_index "tasks", ["priority"], :name => "index_tasks_on_priority"
  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["state"], :name => "index_tasks_on_state"

  create_table "user_events", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_events", ["event_id"], :name => "index_user_events_on_event_id"
  add_index "user_events", ["user_id"], :name => "index_user_events_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "employee_number"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "roles_mask"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
