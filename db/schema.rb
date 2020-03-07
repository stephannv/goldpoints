# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_05_231830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.integer "group", null: false
    t.integer "points", null: false
    t.string "country_code", limit: 2, null: false
    t.datetime "occurred_at", null: false
    t.date "expires_on"
    t.integer "amount_cents", default: 0, null: false
    t.string "amount_currency", default: "USD", null: false
    t.string "description", limit: 32
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expires_on"], name: "index_records_on_expires_on", where: "(expires_on IS NOT NULL)"
    t.index ["occurred_at"], name: "index_records_on_occurred_at"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", limit: 300, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "records", "users"

  create_view "balances", sql_definition: <<-SQL
      SELECT records.user_id,
      records.country_code,
      sum((records.points * records."group")) AS points,
      sum((records.amount_cents * records."group")) AS amount_cents,
      records.amount_currency
     FROM records
    GROUP BY records.user_id, records.country_code, records.amount_currency
   HAVING (sum((records.points * records."group")) > 0);
  SQL
  create_view "points_expirations", sql_definition: <<-SQL
      SELECT r.user_id,
      r.country_code,
      r.expires_on,
      sum(r.amount_cents) AS amount_cents,
      r.amount_currency,
      sum(r.points) AS points
     FROM records r
    WHERE (r.occurred_at > COALESCE(( SELECT max(r2.occurred_at) AS max
             FROM records r2
            WHERE ((r2."group" = '-1'::integer) AND ((r2.country_code)::text = (r.country_code)::text) AND (r2.user_id = r.user_id))), ('1900-01-01'::date)::timestamp without time zone))
    GROUP BY r.user_id, r.country_code, r.expires_on, r.amount_currency
    ORDER BY r.user_id, r.expires_on, (sum(r.points));
  SQL
end
