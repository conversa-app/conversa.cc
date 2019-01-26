# frozen_string_literal: true

class UserMailer < ApplicationMailer
  layout 'user_mailer'
  NO_REPLY = "noreply@#{BRAND.downcase}.com"

  def email_reset_token(user)
    @url = reset_password_url(token: user.password_token)
    mail(
      to: user.email,
      subject: "#{BRAND} - Forgot Password",
      reply_to: NO_REPLY
    )
  end

  def welcome_email(user)
    @user = user
    mail(
      to: user.email,
      subject: "Welcome to #{BRAND}",
      reply_to: NO_REPLY
    )
  end

  def validate_email(user)
    @user = user
    @url = url_for validate_email_url(user.email_validation_token)
    mail(
      to: user.email,
      subject: "Please Validate Your Email #{BRAND}",
      reply_to: NO_REPLY
    )
  end

end
