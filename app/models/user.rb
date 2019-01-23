# == Schema Information
#
# Table name: users
#
#  id                        :bigint(8)        not null, primary key
#  organization_id           :bigint(8)
#  first_name                :string
#  last_name                 :string
#  username                  :string
#  email                     :string
#  phone                     :string
#  password_digest           :string           default(""), not null
#  enabled                   :boolean          default(TRUE)
#  email_validated           :boolean          default(FALSE)
#  email_validation_token    :string
#  remember_token            :string(40)
#  remember_token_expires_at :datetime
#  password_token            :string
#  time_zone                 :string
#  uid                       :integer
#  api_key                   :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class User < ApplicationRecord
  include SessionMethodIncludes
  has_secure_password

  attr_accessor :previous_password

  belongs_to :organization


  before_validation :downcase_email_and_username
  before_create :create_email_validation_token
  after_create :add_agid
  after_update :send_validation_after_email_changed, if: -> { saved_changes[:email] }

  validates :first_name, length: { within: 2..50 }
  validates :last_name, length: { within: 2..50 }

  # validates :username,
  #           length: { within: 8..50 },
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

  default_scope { order('users.last_name ASC, users.first_name ASC') }

  def full_name
    "#{first_name} #{last_name}"
  end

  def enabled?
    enabled ? true : false
  end

  class << self
    def authenticate(email = '', password = '')
      email = email.downcase
      find_by(email: email).try(:authenticate, password)
    end

    def create_token(string = '')
      Digest::SHA1.hexdigest("Take their name #{string} and #{Time.current}")
    end
  end

  def email_reset_token
    token = User.create_token(email)
    update(password_token: token)
    UserMailer.email_reset_token(self).deliver_later
  end

  def create_email_validation_token
    self.email_validation_token = User.create_token(email + rand(1..200_000_000).to_s)
  end

  private

  def add_agid
    if Rails.env == 'development'
      url = 'http://localhost:5000/api/v3/comments?conversation_id=2beujdbeya&agid=1'
    else
      url = 'https://polis-api-proxy.herokuapp.com/api/v3/comments?conversation_id=2beujdbeya&agid=1'
    end
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    if (response.code == '200')
    all_cookies = response.get_fields('set-cookie')
    cookies_array = Array.new
    all_cookies.each { | cookie |
        cookies_array.push(cookie.split('; ')[0])
    }
    agid = cookies_array[0].split('token2=')[1]
    self.agid = agid
    save
    end
  end

  def downcase_email_and_username
    self.email = email.try(:downcase)
    self.username.try(:downcase)
  end

end
