ActiveRecord::Schema.define(version: 2023_04_07_145211) do

  enable_extension "plpgsql"

  create_table "farmers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.integer "prefecture_id", null: false
    t.string "address", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "phone_number", null: false
    t.string "product"
    t.string "website"
    t.string "image"
    t.text "profile"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_farmers_on_user_id"
  end

  create_table "generals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "prefecture_id", null: false
    t.string "address", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_generals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role", null: false
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "farmers", "users"
  add_foreign_key "generals", "users"
end
