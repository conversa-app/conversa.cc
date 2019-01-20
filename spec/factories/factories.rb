# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  sequence :email do |n|
    "basic_email#{n}@gmail.com"
  end

  sequence :slug do |n|
    "slug-#{n}"
  end

  sequence :username do |n|
    "username#{n}"
  end
end
