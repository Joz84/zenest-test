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

ActiveRecord::Schema.define(version: 2019_03_25_172521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attendees", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "event_id"
    t.integer "status", default: 0
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.text "payment_json"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_attendees_on_employee_id"
    t.index ["event_id"], name: "index_attendees_on_event_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "praticien_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "requirement_id"
    t.index ["praticien_id"], name: "index_availabilities_on_praticien_id"
    t.index ["requirement_id"], name: "index_availabilities_on_requirement_id"
  end

  create_table "blog_article_tags", force: :cascade do |t|
    t.bigint "blog_article_id"
    t.bigint "blog_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_article_id"], name: "index_blog_article_tags_on_blog_article_id"
    t.index ["blog_tag_id"], name: "index_blog_article_tags_on_blog_tag_id"
  end

  create_table "blog_articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "photo"
    t.datetime "published_at"
    t.integer "status", default: 0
    t.bigint "blog_author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["blog_author_id"], name: "index_blog_articles_on_blog_author_id"
    t.index ["slug"], name: "index_blog_articles_on_slug", unique: true
  end

  create_table "blog_authors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_blog_authors_on_slug", unique: true
  end

  create_table "blog_meta", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "blog_article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_article_id"], name: "index_blog_meta_on_blog_article_id"
  end

  create_table "blog_tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_blog_tags_on_slug", unique: true
  end

  create_table "booking_restrictions", force: :cascade do |t|
    t.bigint "company_id"
    t.bigint "massage_category_id"
    t.integer "periodicity", default: 0
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_booking_restrictions_on_company_id"
    t.index ["massage_category_id"], name: "index_booking_restrictions_on_massage_category_id"
  end

  create_table "calendar_days", force: :cascade do |t|
    t.bigint "calendar_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_calendar_days_on_calendar_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.bigint "company_id"
    t.integer "google_id"
    t.string "name"
    t.boolean "active", default: false
    t.boolean "payable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_calendars_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "address"
    t.string "name"
    t.string "siret"
    t.string "city"
    t.string "logo"
    t.string "zipcode"
    t.string "company_code"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "email_extension_active", default: false
  end

  create_table "competencies", force: :cascade do |t|
    t.bigint "praticien_id"
    t.bigint "massage_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["massage_category_id"], name: "index_competencies_on_massage_category_id"
    t.index ["praticien_id"], name: "index_competencies_on_praticien_id"
  end

  create_table "default_events", force: :cascade do |t|
    t.bigint "event_group_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "massage_category_id"
    t.bigint "room_id"
    t.text "description"
    t.string "photo"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.string "title"
    t.integer "max_attendees", default: 15
    t.integer "min_attendees", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "morning"
    t.index ["event_group_id"], name: "index_default_events_on_event_group_id"
    t.index ["massage_category_id"], name: "index_default_events_on_massage_category_id"
    t.index ["room_id"], name: "index_default_events_on_room_id"
  end

  create_table "email_extensions", force: :cascade do |t|
    t.string "name"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_email_extensions_on_company_id"
  end

  create_table "employees", force: :cascade do |t|
    t.bigint "company_id"
    t.integer "stripe_id"
    t.boolean "admin_company", default: false
    t.string "matricule"
    t.text "complement_infos"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "conditions_validation", default: false
    t.index ["company_id"], name: "index_employees_on_company_id"
  end

  create_table "event_groups", force: :cascade do |t|
    t.bigint "calendar_id"
    t.bigint "massage_category_id"
    t.bigint "room_id"
    t.text "description"
    t.string "photo"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.string "title"
    t.integer "duration"
    t.integer "massage_by_slot"
    t.time "morning_date"
    t.integer "morning_duplication", default: 0
    t.time "afternoon_date"
    t.integer "afternoon_duplication", default: 0
    t.integer "max_attendees", default: 15
    t.integer "min_attendees", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_event_groups_on_calendar_id"
    t.index ["massage_category_id"], name: "index_event_groups_on_massage_category_id"
    t.index ["room_id"], name: "index_event_groups_on_room_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "massage_category_id"
    t.bigint "room_id"
    t.bigint "calendar_day_id"
    t.bigint "praticien_id"
    t.text "description"
    t.string "photo"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.integer "status", default: 0
    t.string "title"
    t.integer "max_attendees", default: 15
    t.integer "min_attendees", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "confirmed_attendees_count", default: 0
    t.integer "cancelled_attendees_count", default: 0
    t.bigint "event_group_id"
    t.index ["calendar_day_id"], name: "index_events_on_calendar_day_id"
    t.index ["event_group_id"], name: "index_events_on_event_group_id"
    t.index ["massage_category_id"], name: "index_events_on_massage_category_id"
    t.index ["praticien_id"], name: "index_events_on_praticien_id"
    t.index ["room_id"], name: "index_events_on_room_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "title"
    t.string "pdf"
    t.datetime "date"
    t.string "invoiceable_type"
    t.bigint "invoiceable_id"
    t.string "reference"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoiceable_type", "invoiceable_id"], name: "index_invoices_on_invoiceable_type_and_invoiceable_id"
  end

  create_table "massage_categories", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.boolean "individual", default: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "praticiens", force: :cascade do |t|
    t.integer "gender"
    t.string "photo"
    t.boolean "available", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requirements", force: :cascade do |t|
    t.bigint "massage_category_id"
    t.bigint "calendar_day_id"
    t.integer "nb_praticiens"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "EUR", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_day_id"], name: "index_requirements_on_calendar_day_id"
    t.index ["massage_category_id"], name: "index_requirements_on_massage_category_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "company_id"
    t.string "name"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_rooms_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "birthday"
    t.string "address"
    t.string "zipcode"
    t.string "city"
    t.string "phone"
    t.string "complement"
    t.string "actable_type"
    t.bigint "actable_id"
    t.boolean "active", default: true
    t.boolean "admin", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["actable_type", "actable_id"], name: "index_users_on_actable_type_and_actable_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendees", "employees"
  add_foreign_key "attendees", "events"
  add_foreign_key "availabilities", "praticiens"
  add_foreign_key "availabilities", "requirements"
  add_foreign_key "blog_article_tags", "blog_articles"
  add_foreign_key "blog_article_tags", "blog_tags"
  add_foreign_key "blog_articles", "blog_authors"
  add_foreign_key "blog_meta", "blog_articles"
  add_foreign_key "booking_restrictions", "companies"
  add_foreign_key "booking_restrictions", "massage_categories"
  add_foreign_key "calendar_days", "calendars"
  add_foreign_key "calendars", "companies"
  add_foreign_key "competencies", "massage_categories"
  add_foreign_key "competencies", "praticiens"
  add_foreign_key "default_events", "event_groups"
  add_foreign_key "default_events", "massage_categories"
  add_foreign_key "default_events", "rooms"
  add_foreign_key "email_extensions", "companies"
  add_foreign_key "employees", "companies"
  add_foreign_key "event_groups", "calendars"
  add_foreign_key "event_groups", "massage_categories"
  add_foreign_key "event_groups", "rooms"
  add_foreign_key "events", "calendar_days"
  add_foreign_key "events", "event_groups"
  add_foreign_key "events", "massage_categories"
  add_foreign_key "events", "praticiens"
  add_foreign_key "events", "rooms"
  add_foreign_key "requirements", "calendar_days"
  add_foreign_key "requirements", "massage_categories"
  add_foreign_key "rooms", "companies"
end
