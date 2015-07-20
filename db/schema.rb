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

ActiveRecord::Schema.define(version: 20150720192232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "group_id"
    t.boolean  "is_deleted",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "categories", ["group_id"], name: "index_categories_on_group_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "is_deleted", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "pincode"
    t.string   "email"
    t.string   "contact_no"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.boolean  "is_deleted",        default: false
    t.string   "is_disabled",       default: "f"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string   "title"
    t.integer  "category_id"
    t.boolean  "is_deleted",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "documents", ["category_id"], name: "index_documents_on_category_id", using: :btree

  create_table "download_logs", force: :cascade do |t|
    t.integer  "file_datum_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "download_logs", ["file_datum_id"], name: "index_download_logs_on_file_datum_id", using: :btree
  add_index "download_logs", ["user_id"], name: "index_download_logs_on_user_id", using: :btree

  create_table "file_data", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "post_id"
    t.integer  "document_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "file_data", ["document_id"], name: "index_file_data_on_document_id", using: :btree
  add_index "file_data", ["post_id"], name: "index_file_data_on_post_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "customer_id"
    t.boolean  "is_deleted",         default: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "groups", ["customer_id"], name: "index_groups_on_customer_id", using: :btree

  create_table "groups_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups_users", ["group_id"], name: "index_groups_users_on_group_id", using: :btree
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.boolean  "is_readed",   default: false
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "document_id"
    t.integer  "comment_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "notifications", ["comment_id"], name: "index_notifications_on_comment_id", using: :btree
  add_index "notifications", ["document_id"], name: "index_notifications_on_document_id", using: :btree
  add_index "notifications", ["post_id"], name: "index_notifications_on_post_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "category_id"
    t.boolean  "is_deleted",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "posts", ["category_id"], name: "index_posts_on_category_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "contact_no"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "role_id"
    t.integer  "customer_id"
    t.boolean  "is_deleted",             default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["customer_id"], name: "index_users_on_customer_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "categories", "groups"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "documents", "categories"
  add_foreign_key "download_logs", "file_data"
  add_foreign_key "download_logs", "users"
  add_foreign_key "file_data", "documents"
  add_foreign_key "file_data", "posts"
  add_foreign_key "groups", "customers"
  add_foreign_key "groups_users", "groups"
  add_foreign_key "groups_users", "users"
  add_foreign_key "notifications", "comments"
  add_foreign_key "notifications", "documents"
  add_foreign_key "notifications", "posts"
  add_foreign_key "notifications", "users"
  add_foreign_key "posts", "categories"
  add_foreign_key "users", "customers"
  add_foreign_key "users", "roles"
end
