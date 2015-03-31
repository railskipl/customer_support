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

ActiveRecord::Schema.define(version: 20150323061256) do

  create_table "abuse_reports", force: true do |t|
    t.string   "user_email"
    t.text     "message"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: true do |t|
    t.integer  "town_id"
    t.integer  "location_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertises", force: true do |t|
    t.string   "image"
    t.integer  "position"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_msg"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "review_id"
    t.text     "title"
    t.integer  "supplier_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ispublished",          default: false
    t.string   "name"
    t.string   "email"
    t.text     "modified_comment"
    t.boolean  "admin_sagent_comment", default: false
  end

  create_table "companies", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_registered", default: false
  end

  create_table "company_performances", force: true do |t|
    t.text     "best_performance"
    t.text     "worst_performance"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "performance_img"
    t.string   "box_type"
  end

  create_table "contact_us", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "telephone"
    t.string   "message_type"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "faqs", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.integer  "question_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.integer  "town_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintainences", force: true do |t|
    t.boolean  "status",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monitor_jagents", force: true do |t|
    t.integer  "review_id"
    t.boolean  "ticked_closed_by_jagent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archive"
    t.boolean  "modified_review"
    t.boolean  "s_comment"
    t.boolean  "c_comment"
    t.boolean  "archive_att"
    t.string   "status"
    t.string   "comment_status"
  end

  create_table "nature_of_reviews", force: true do |t|
    t.string   "title"
    t.string   "user_id"
    t.string   "review_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "comment_id"
    t.boolean  "is_read",            default: false
    t.integer  "receiver_agent_id"
    t.integer  "receiver_jagent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment_status"
    t.boolean  "admin_status",       default: false
  end

  create_table "options", force: true do |t|
    t.string   "answer"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "title"
    t.string   "subtitle"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "template_name", default: "index"
    t.text     "quote"
  end

  create_table "polls", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "published",  default: false
  end

  create_table "resource_types", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_types", ["slug"], name: "index_resource_types_on_slug", using: :btree

  create_table "resources", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "resource_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", force: true do |t|
    t.integer  "poll_id"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "review_notes", force: true do |t|
    t.string   "name"
    t.text     "note"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.string   "title"
    t.integer  "industry_id"
    t.integer  "company_id"
    t.date     "date"
    t.integer  "town_id"
    t.time     "datetime"
    t.integer  "location_id"
    t.string   "personal_responsible"
    t.string   "nature_of_review"
    t.text     "message"
    t.string   "account_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticket_number"
    t.string   "review_type"
    t.integer  "user_id"
    t.string   "guest_token"
    t.string   "file"
    t.boolean  "archive",                 default: false
    t.boolean  "ispublished",             default: false
    t.datetime "published_date"
    t.datetime "change_date"
    t.text     "modified_review"
    t.boolean  "is_modified"
    t.text     "notes"
    t.boolean  "archive_attachment",      default: false
    t.boolean  "is_ticket_open",          default: true
    t.integer  "jagent_id"
    t.integer  "agent_id"
    t.integer  "old_jagent_id"
    t.integer  "last_published_agent_id"
    t.boolean  "admin_sagent_modified",   default: false
    t.string   "desired_outcome"
  end

  create_table "seos", force: true do |t|
    t.string   "meta_title"
    t.text     "meta_description"
    t.text     "meta_keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "suppliers", force: true do |t|
    t.string   "email",                default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address_line1"
    t.text     "address_line2"
    t.string   "town"
    t.string   "city"
    t.string   "country"
    t.string   "title"
    t.string   "telephone_number"
    t.string   "mobile_number"
    t.string   "subscription"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "supplier_name"
    t.string   "supplier_vat_Number"
    t.string   "industry"
    t.string   "authorised_responder"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_resp2"
    t.string   "title2"
    t.string   "fname2"
    t.string   "lname2"
    t.string   "email2"
    t.string   "tno2"
    t.string   "mno2"
    t.string   "auth_resp3"
    t.string   "title3"
    t.string   "fname3"
    t.string   "lname3"
    t.string   "email3"
    t.string   "tno3"
    t.string   "mno3"
    t.text     "notes"
  end

  create_table "towns", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "track_times", force: true do |t|
    t.integer  "review_id"
    t.date     "date_proposed"
    t.date     "date_complete"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "secret_question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                default: 4
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "age"
    t.date     "dob"
    t.string   "country"
    t.string   "pobox"
    t.integer  "postal_code"
    t.string   "town"
    t.string   "lives_in"
    t.string   "avatar"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "role",                   default: "user"
    t.string   "preferred_alias"
    t.boolean  "accept_t_and_c",         default: false
    t.string   "guest_token"
    t.boolean  "is_subscribe"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
