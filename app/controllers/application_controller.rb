class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
 # before_action :set_raven_context
  before_action :confirm_user_login

  include SessionMethods

  WHITE_LIST_ENVS = %w[development test].freeze

  HTTP_AUTH_USERS = { 'conversa' => 'user!',
                      'client' => 'conversa#nyc' }.freeze

  def http_authenticate
    return if WHITE_LIST_ENVS.include?(Rails.env)

    authenticate_or_request_with_http_basic do |username, password|
      HTTP_AUTH_USERS.fetch(username, false) == password
    end
  end

  # ensures staff logged in, otherwise redirects to login page.
  def confirm_user_login
    unless user_logged_in?
      session[:desired_url] = url_for(santize_parameters)
      flash[:warning] = 'Please log in.'
      redirect_to(login_path)
    end
    true
  end

  # Returns the client's time zone based on a cookie set by the browser, defaults to application time zone

  helper_method :browser_time_zone

  def validate_email_reminder
    unless @current_user.email_validated
      flash.now[:danger] = "
      <div class='container'><div class='row'>
          <div class='col-md-8 text-left'>Confirm your email address to access all of #{BRAND}'s features. <br />
                  A confirmation message was sent to #{@current_user.email}</div>
          <div class='mt-1 col-md-4 text-md-right text-left'><a href=#{resend_validation_email_users_path} class='btn btn-danger text-light'>Resend Confirmation</a></div>
          </div></div>
      ".html_safe
    end
  end

  def santize_parameters
    params.permit(
      %i[
        current_page
        page
        id
      ]
    )
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

end
