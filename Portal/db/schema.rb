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

ActiveRecord::Schema.define(version: 20170517055755) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "balance_sheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.date     "month_year"
    t.decimal  "office_income",            precision: 10, scale: 2
    t.decimal  "office_expense",           precision: 10, scale: 2
    t.decimal  "office_net_salary",        precision: 10, scale: 2
    t.decimal  "office_overall_salary",    precision: 10, scale: 2
    t.decimal  "diff_net_overall_salary",  precision: 10, scale: 2
    t.decimal  "office_share",             precision: 10, scale: 2
    t.decimal  "gopi_share",               precision: 10, scale: 2
    t.decimal  "saran_share",              precision: 10, scale: 2
    t.decimal  "office_profit_loss",       precision: 10, scale: 2
    t.decimal  "gopi_profit_loss",         precision: 10, scale: 2
    t.decimal  "saran_profit_loss",        precision: 10, scale: 2
    t.decimal  "amount_received_by_gopi",  precision: 10, scale: 2
    t.decimal  "amount_received_by_saran", precision: 10, scale: 2
    t.decimal  "amount_spent_by_gopi",     precision: 10, scale: 2
    t.decimal  "amount_spent_by_saran",    precision: 10, scale: 2
    t.decimal  "balance_money_to_gopi",    precision: 10, scale: 2
    t.decimal  "balance_money_to_saran",   precision: 10, scale: 2
    t.decimal  "gopi_total_pay",           precision: 10, scale: 2
    t.decimal  "saran_total_pay",          precision: 10, scale: 2
    t.decimal  "final_total_pay_to_gopi",  precision: 10, scale: 2
    t.decimal  "final_total_pay_to_saran", precision: 10, scale: 2
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "client_companies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "client_id"
    t.string   "name"
    t.string   "contact_number"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "client_social_networks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "client_id"
    t.integer  "social_network_id"
    t.text     "profile_id",        limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "clients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "email",                                  default: "", null: false
    t.string   "encrypted_password",                     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "contact_number"
    t.string   "secondary_email"
    t.string   "secondary_contact_number"
    t.text     "address",                  limit: 65535
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip_code"
    t.boolean  "is_active"
    t.boolean  "same_as_client_address"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["email"], name: "index_clients_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree
  end

  create_table "education_certificates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_address_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "employee_address_type_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zipcode"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "employee_agreement_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employee_agreements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "employee_agreement_type_id"
    t.string   "photo_copy"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "employee_bank_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "account_number"
    t.string   "bank_name"
    t.string   "bank_branch"
    t.string   "ifsc_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "employee_ctc_monthlies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "employee_ctc_year_id"
    t.date     "month_year"
    t.bigint   "employee_id"
    t.decimal  "basic_pay",                       precision: 10, scale: 2
    t.decimal  "hra",                             precision: 10, scale: 2
    t.decimal  "house_rent",                      precision: 10, scale: 2
    t.decimal  "tax_deduction",                   precision: 10, scale: 2
    t.decimal  "special_allowance",               precision: 10, scale: 2
    t.decimal  "telephone_allowance",             precision: 10, scale: 2
    t.decimal  "medical_allowance",               precision: 10, scale: 2
    t.decimal  "pf_employeer_contribution",       precision: 10, scale: 2
    t.decimal  "pf_employee_contribution",        precision: 10, scale: 2
    t.decimal  "gratuity_employeer_contribution", precision: 10, scale: 2
    t.decimal  "professonal_tax",                 precision: 10, scale: 2
    t.decimal  "loss_of_pay",                     precision: 10, scale: 2
    t.decimal  "total_earnings",                  precision: 10, scale: 2
    t.decimal  "total_deduction",                 precision: 10, scale: 2
    t.decimal  "net_salary",                      precision: 10, scale: 2
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "incentive",                       precision: 10, scale: 2
    t.decimal  "lop_basic",                       precision: 10, scale: 2
    t.decimal  "lop_hra",                         precision: 10, scale: 2
    t.decimal  "lop_special_allowance",           precision: 10, scale: 2
    t.decimal  "estimate_medical",                precision: 10, scale: 2
    t.decimal  "estimate_mobile",                 precision: 10, scale: 2
    t.decimal  "estimate_special_allowance",      precision: 10, scale: 2
  end

  create_table "employee_ctc_years", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.decimal  "basic_pay",                       precision: 10, scale: 2
    t.decimal  "hra",                             precision: 10, scale: 2
    t.decimal  "pf_employeer_contribution",       precision: 10, scale: 2
    t.decimal  "gratuity_employeer_contribution", precision: 10, scale: 2
    t.decimal  "medical_insurance",               precision: 10, scale: 2
    t.decimal  "special_allowance",               precision: 10, scale: 2
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.decimal  "incentive",                       precision: 10, scale: 2
  end

  create_table "employee_education_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "employee_qualification_detail_id"
    t.integer  "education_certificate_id"
    t.string   "certificate_id"
    t.string   "photo_copy"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "employee_emergency_contact_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "contact_person_name"
    t.string   "relationship"
    t.boolean  "primary"
    t.string   "contact_number"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "employee_employment_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "employee_professional_detail_id"
    t.integer  "employment_certificate_id"
    t.string   "photo_copy"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "employee_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "language"
    t.integer  "speaking_proficiency_id"
    t.integer  "writing_proficiency_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "employee_leave_balances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "leave_type_id"
    t.decimal  "leave_balance", precision: 10, scale: 2
    t.integer  "current_month"
    t.integer  "current_year"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "employee_loss_of_pays", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "month"
    t.integer  "year"
    t.string   "leave_period"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "employee_monthly_work_reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.float    "company_working_days", limit: 24
    t.float    "employee_worked_days", limit: 24
    t.float    "loss_of_pay",          limit: 24
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "employee_personal_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "contact_number_1"
    t.string   "contact_number_2"
    t.string   "personal_email"
    t.string   "gender"
    t.string   "blood_group"
    t.string   "avatar"
    t.text     "identity_mark_1",             limit: 65535
    t.text     "identity_mark_2",             limit: 65535
    t.string   "pan_number"
    t.string   "adhaar_card_number"
    t.string   "driving_license_number"
    t.string   "voter_id"
    t.string   "passport_number"
    t.date     "passport_expiry_date"
    t.string   "passport_registration_place"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "employee_professional_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "employment_name"
    t.date     "from_date"
    t.date     "to_date"
    t.string   "designation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "employee_qualification_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "education_degree"
    t.string   "year_of_passing"
    t.string   "institution_name"
    t.string   "university_board"
    t.string   "percentage"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "employee_yearly_leave_balances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "year"
    t.integer  "leave_type_id"
    t.float    "leave_balance", limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "email",                                           default: "", null: false
    t.string   "encrypted_password",                              default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.bigint   "employee_id"
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.date     "dob"
    t.integer  "role_id"
    t.bigint   "supervisor_id"
    t.string   "first_password"
    t.boolean  "is_active"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.integer  "current_month"
    t.integer  "current_year"
    t.decimal  "ctc",                    precision: 10, scale: 2
    t.index ["email"], name: "index_employees_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
  end

  create_table "employment_certificates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "project_id"
    t.bigint   "client_id"
    t.text     "feedback",    limit: 65535
    t.integer  "employee_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "leave_permission_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leave_request_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.bigint   "approver_id"
    t.integer  "leave_request_id"
    t.integer  "leave_permission_status_id"
    t.text     "description",                limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "leave_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.bigint   "approver_id"
    t.float    "no_of_days",                 limit: 24
    t.date     "from_date"
    t.date     "to_date"
    t.text     "reason",                     limit: 65535
    t.integer  "leave_permission_status_id"
    t.integer  "leave_type_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "leave_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_calendars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_organizer_id"
    t.integer  "client_organizer_id"
    t.string   "event_title"
    t.date     "from_date"
    t.time     "from_time"
    t.time     "to_time"
    t.datetime "time_zone"
    t.text     "description",                   limit: 65535
    t.string   "meeting_attachment"
    t.string   "meeting_event_repeat_id"
    t.string   "meeting_event_notification_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "meeting_event_notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_event_repeats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_guests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "meeting_calendar_id"
    t.bigint   "employee_guest_id"
    t.integer  "client_guest_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "monthly_employee_net_salaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.decimal  "net_salary",      precision: 10, scale: 2
    t.date     "month_year"
    t.decimal  "total_earnings",  precision: 10, scale: 2
    t.decimal  "total_deduction", precision: 10, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "office_balance_sheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "year"
    t.string   "month"
    t.decimal  "office_income",   precision: 10, scale: 2
    t.decimal  "office_expense",  precision: 10, scale: 2
    t.decimal  "office_share",    precision: 10, scale: 2
    t.decimal  "gopinath_share",  precision: 10, scale: 2
    t.decimal  "saravanan_share", precision: 10, scale: 2
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "office_expenses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "spent_year"
    t.string   "spent_month"
    t.date     "spent_date"
    t.string   "description"
    t.integer  "transaction_via_id"
    t.decimal  "money_spent",        precision: 10, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "office_incomes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "client_id"
    t.integer  "project_id"
    t.integer  "transaction_via_id"
    t.string   "money_received_month"
    t.string   "money_received_year"
    t.date     "money_received_date"
    t.decimal  "money_received",       precision: 10, scale: 2
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "office_salaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "salary_year"
    t.string   "salary_month"
    t.date     "salary_date"
    t.decimal  "breakage_money",        precision: 10, scale: 2
    t.decimal  "balance_money_to_give", precision: 10, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.decimal  "salary",                precision: 10, scale: 2
  end

  create_table "office_salary_breakages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "given_year"
    t.string   "given_month"
    t.date     "given_date"
    t.decimal  "money_given",   precision: 10, scale: 2
    t.decimal  "money_to_give", precision: 10, scale: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "permission_request_activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.bigint   "approver_id"
    t.integer  "permission_request_id"
    t.integer  "leave_permission_status_id"
    t.text     "description",                limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "permission_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.bigint   "approver_id"
    t.date     "permission_date"
    t.time     "from_time"
    t.time     "to_time"
    t.time     "no_of_hours"
    t.text     "reason",                     limit: 65535
    t.integer  "leave_permission_status_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "privacy_policies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.text     "topic",       limit: 65535
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "for_client"
  end

  create_table "project_employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "project_id"
    t.integer  "client_id"
    t.bigint   "employee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "project_id"
    t.string   "client_id"
    t.string   "name"
    t.string   "short_name"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "is_active"
    t.integer  "employee_id"
  end

  create_table "projects_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "project_id"
    t.string   "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "share_holders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.decimal  "percentage", precision: 10, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "social_networks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "network_name"
    t.string   "network_short_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "speaking_proficiencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "task_id"
    t.string   "file"
    t.integer  "task_comment_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "task_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.integer  "task_id"
    t.bigint   "employee_id"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.bigint   "client_id"
  end

  create_table "task_employee_timers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "task_id"
    t.bigint   "timer_duration"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "task_priorities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_timers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.string   "task_id"
    t.bigint   "lap_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_taken",    default: false
  end

  create_table "task_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "project_task_id"
    t.integer  "project_id"
    t.bigint   "employee_id"
    t.text     "title",              limit: 65535
    t.text     "description",        limit: 65535
    t.integer  "task_type_id"
    t.integer  "task_priority_id"
    t.integer  "task_status_id"
    t.date     "start_date"
    t.date     "due_date"
    t.time     "estimated_hours"
    t.time     "actual_hours_taken"
    t.boolean  "hide_to_client"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "time_sheet_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_sheets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint   "employee_id"
    t.integer  "task_id"
    t.date     "entry_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint   "hours_taken"
    t.boolean  "billable"
    t.text     "description",          limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.bigint   "approver_id"
    t.bigint   "time_sheet_status_id"
  end

  create_table "transaction_via", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "writing_proficiencies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yearly_holiday_calendars", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.date     "holiday_date"
    t.text     "description",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
