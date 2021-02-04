# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_04_122551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tds_common_lib_abilities", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_type", null: false
    t.string "permission", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "user_type", "permission"], name: "index_abilities", unique: true
  end

  create_table "tds_common_lib_database_backup_files", force: :cascade do |t|
    t.string "file_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "database_backup_id", null: false
    t.index ["database_backup_id"], name: "index_database_backup_files_on_database_backup_id"
  end

  create_table "tds_common_lib_database_backups", force: :cascade do |t|
    t.string "name", null: false
    t.string "database_name", null: false
    t.boolean "is_active", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tds_common_lib_database_backups_on_name", unique: true
  end

  add_foreign_key "tds_common_lib_database_backup_files", "tds_common_lib_database_backups", column: "database_backup_id", on_delete: :cascade
end
