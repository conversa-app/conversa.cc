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

ActiveRecord::Schema.define(version: 2019_01_23_165309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "password_digest", default: "", null: false
    t.boolean "enabled", default: true
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.string "password_token"
    t.string "time_zone", default: "UTC"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email"
    t.index ["first_name"], name: "index_admins_on_first_name"
    t.index ["last_name"], name: "index_admins_on_last_name"
    t.index ["remember_token"], name: "index_admins_on_remember_token"
    t.index ["username"], name: "index_admins_on_username"
  end

  create_table "comment_votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "comment_id"
    t.integer "vote", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_votes_on_comment_id"
    t.index ["user_id", "comment_id"], name: "index_comments_cid_and_uId"
    t.index ["user_id"], name: "index_comment_votes_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "content"
    t.boolean "votable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.string "auth_needed_to_vote"
    t.string "auth_needed_to_write"
    t.string "auth_opt_fb"
    t.string "auth_opt_tw"
    t.string "auth_opt_allow_3rdparty"
    t.string "auth_opt_fb_computed"
    t.string "auth_opt_tw_computed"
    t.bigint "user_id"
    t.bigint "organization_id"
    t.boolean "is_active", default: true
    t.boolean "is_draft", default: true
    t.boolean "is_public", default: true
    t.boolean "profanity_filter", default: true
    t.boolean "spam_filter", default: true
    t.boolean "is_anon", default: false
    t.boolean "is_data_open", default: false
    t.boolean "is_slack", default: false
    t.boolean "lti_users_only", default: false
    t.boolean "owner_sees_participation_stats", default: false
    t.boolean "prioritize_seed", default: false
    t.boolean "strict_moderation", default: false
    t.boolean "use_xid_whitelist", default: false
    t.text "topic"
    t.string "bgcolor"
    t.string "help_bgcolor"
    t.string "help_color"
    t.string "help_type"
    t.string "context"
    t.string "email_domain"
    t.string "conversation_id"
    t.integer "course_id"
    t.integer "participant_count"
    t.integer "socialbtn_type"
    t.integer "subscribe_type"
    t.integer "upvotes"
    t.integer "vis_type"
    t.integer "write_hint_type"
    t.integer "write_type"
    t.string "dataset_explanation"
    t.string "link_url"
    t.string "parent_url"
    t.string "style_btn"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_conversations_on_organization_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.integer "uid"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "phone"
    t.string "password_digest", default: "", null: false
    t.boolean "enabled", default: true
    t.boolean "email_validated", default: false
    t.string "email_validation_token"
    t.string "remember_token", limit: 40
    t.datetime "remember_token_expires_at"
    t.string "password_token"
    t.string "time_zone"
    t.integer "uid"
    t.string "api_key"
    t.string "agid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["email_validation_token"], name: "index_users_on_email_validation_token"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["remember_token"], name: "index_users_on_remember_token"
    t.index ["username"], name: "index_users_on_username"
  end

end
