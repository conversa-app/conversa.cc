# frozen_string_literal: true

class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(FactoryBot.build(:user))
  end

  def validate_email
    UserMailer.validate_email(FactoryBot.build(:user, email_validation_token: 'asdasdsad'))
  end

  def email_reset_token
    UserMailer.email_reset_token(FactoryBot.build(:user, password_token: 'asdasdsad'))
  end
end
