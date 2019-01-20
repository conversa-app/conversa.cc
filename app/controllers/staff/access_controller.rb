# frozen_string_literal: true

class Staff::AccessController < StaffController
  before_action :confirm_staff_login, only: %i[menu destroy]

  def index
    menu
    render('menu')
  end

  def menu
    # just text
  end

  def new
    @hide_navigation = true
    # display login form
  end

  def create
    logout_keeping_session!('admin')
    found_admin = Admin.authenticate(params['email'], params['password'])
    if found_admin && found_admin.enabled?
      self.current_admin = found_admin
      handle_remember_cookie!(true, Admin) if params[:remember_me] == '1' || Rails.env.development?
      flash[:primary] = 'You are now logged in.'
      redirect_to_desired_url(staff_menu_path)
    elsif found_admin && !found_admin.enabled?
      @hide_navigation = true
      flash[:error] = 'Your account has been disabled.'
      render('new')
    else
      @hide_navigation = true
      flash[:error] = 'Adminname/password combination not found. Please try again.'
      render('new')
    end
  end

  def destroy
    logout_keeping_session!('admin')
    flash[:notice] = 'You are now logged out.'
    redirect_to(staff_login_path)
  end

  #--- Password Methods ---

  def forgot_password
    @hide_navigation = true
    # display form
  end

  def send_reset_token
    @admin = Admin.where(email: params[:email], enabled: true).first
    if @admin
      @admin.email_reset_token
      flash[:warning] = 'Reset Link Sent'
      redirect_to staff_login_path
    else
      flash[:warning] = 'Email address not found'
      render('forgot_password')
    end
  end

  def reset_password
    @admin = Admin.find_by(password_token: params[:token])
    # NB: a blank params[:token] will find members without password_token
    if @admin && @admin.password_token.present?
      render('reset_password')
    else
      render('reset_password_failed')
    end
  end

  def update_password
    @admin = Admin.find_by(password_token: params[:token])
    if @admin
      @admin.password = params[:password]
      @admin.password_confirmation = params[:password_confirmation]
      @admin.password_token = nil
      if @admin.save
        flash['primary'] = 'Password Successfully Reset'
        redirect_to staff_login_path
      else
        render('reset_password')
      end
    else
      render('reset_password_failed')
    end
  end

  private

  def redirect_to_desired_url(fallback_url = { action: 'index' })
    if session[:desired_url]
      desired_url = session[:desired_url]
      session[:desired_url] = nil
      redirect_to(desired_url)
    else
      redirect_to(fallback_url)
    end
  end
end
