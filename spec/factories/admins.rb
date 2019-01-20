# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                        :bigint(8)        not null, primary key
#  first_name                :string
#  last_name                 :string
#  username                  :string
#  email                     :string
#  password_digest           :string           default(""), not null
#  enabled                   :boolean          default(TRUE)
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  password_token            :string
#  time_zone                 :string           default("UTC")
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

FactoryBot.define do
  factory :admin do |u|
    u.first_name { 'John' }
    u.last_name { 'Doe' }
    u.username { FactoryBot.generate(:username) }
    u.email { FactoryBot.generate(:email) }
    u.password { 'my_password' }
  end
end
