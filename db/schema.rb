# frozen_string_literal: true

ActiveRecord::Schema.define(version: 20_201_119_154_358) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'role', default: 0
  end
end
