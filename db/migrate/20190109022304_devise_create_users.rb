# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.belongs_to :organization
      t.string   'first_name'
      t.string   'last_name'
      t.string   'username'
      t.string   'email'
      t.string   'phone'
      t.string   'password_digest',                      default: '', null: false
      t.boolean  'enabled',                              default: true
      t.boolean  'email_validated',                      default: false
      t.string   'email_validation_token'
      t.string   'remember_token', limit: 40
      t.datetime 'remember_token_expires_at'
      t.string   'password_token'
      t.string   'time_zone'
      t.index ['email'], name: 'index_users_on_email', using: :btree
      t.index ['first_name'], name: 'index_users_on_first_name', using: :btree
      t.index ['last_name'], name: 'index_users_on_last_name', using: :btree
      t.index ['remember_token'], name: 'index_users_on_remember_token', using: :btree
      t.index ['email_validation_token'], name: 'index_users_on_email_validation_token', using: :btree
      t.index ['username'], name: 'index_users_on_username', using: :btree
      t.timestamps
    end
  end
end
