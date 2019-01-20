# frozen_string_literal: true

class DeviseCreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string   'first_name'
      t.string   'last_name'
      t.string   'username'
      t.string   'email'
      t.string   'password_digest',                      default: '', null: false
      t.boolean  'enabled',                              default: true
      t.string   'remember_token', limit: 40
      t.datetime 'remember_token_expires_at'
      t.string   'password_token'
      t.string :time_zone, default: 'UTC'
      t.index ['email'], name: 'index_admins_on_email', using: :btree
      t.index ['first_name'], name: 'index_admins_on_first_name', using: :btree
      t.index ['last_name'], name: 'index_admins_on_last_name', using: :btree
      t.index ['remember_token'], name: 'index_admins_on_remember_token', using: :btree
      t.index ['username'], name: 'index_admins_on_username', using: :btree
      t.timestamps
    end
  end
end
