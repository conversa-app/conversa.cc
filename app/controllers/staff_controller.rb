class StaffController < ApplicationController
  skip_before_action :confirm_user_login
  before_action :confirm_staff_login

  layout 'staff'

  private

  # ensures staff logged in, otherwise redirects to login page.
  def confirm_staff_login
    unless admin_logged_in?
      session[:desired_url] = url_for(santize_parameters)
      flash[:notice] = 'Please log in.'
      redirect_to(new_staff_access_path)
    end
    true
  end

end