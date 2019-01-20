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

class Admin < ApplicationRecord
  include SessionMethodIncludes
  has_secure_password

  class_attribute :cookie_path
  self.cookie_path = '/staff'

  attr_accessor :previous_password

  cattr_accessor :per_page
  self.per_page = 15

  validates :first_name, length: { within: 3..50 }
  validates :last_name, length: { within: 3..50 }

  # validates :username,
  #           length: { within: 5..50 },
  #           format: { with: /\A([a-z0-9_@\.]+)\Z/i },
  #           uniqueness: { case_sensitive: false, message: 'Username already exists' }

  validates :password,
            length: { within: 8..25 },
            on: :create

  validates :password,
            length: { within: 8..25 },
            on: :update,
            allow_blank: true

  validates :email,
            uniqueness: { case_sensitive: false, message: 'Email address already has an account associated with it.' },
            format: { with: STANDARD_EMAIL_REGEX, message: 'Email address is invalid ' },
            confirmation: { if: :email_changed? },
            length: { within: 5..255 }

  default_scope { order('admins.last_name ASC, admins.first_name ASC') }

  def full_name
    "#{first_name} #{last_name}"
  end

  def enabled?
    enabled ? true : false
  end

  class << self
    def authenticate(username = '', password = '')
      username = username.downcase
      find_by(username: username).try(:authenticate, password) || find_by(email: username).try(:authenticate, password)
    end

    def create_token(string = '')
      Digest::SHA1.hexdigest("Take their name #{string} and #{Time.current}")
    end
  end

  def email_reset_token
    token = Admin.create_token(email)
    update(password_token: token)
    AdminMailer.email_reset_token(self).deliver_later
  end
end