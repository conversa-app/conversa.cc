# frozen_string_literal: true

class AccessController < ApplicationController
  skip_before_action :confirm_user_login, except: [:destroy]
  
  def new
    # display login form
  end

  def create
    logout_keeping_session!('user')
    found_user = User.authenticate(params['email'], params['password'])
    if found_user && found_user.enabled?
      self.current_user = found_user
      handle_remember_cookie!(true, User) if params[:remember_me] == '1' || Rails.env.development?
      flash[:primary] = 'You are now logged in.'
      redirect_to_desired_url(conversations_path)
    elsif found_user && !found_user.enabled?
      @hide_navigation = true
      flash[:error] = 'Your account has been disabled.'
      render('new')
    else
      @hide_navigation = true
      flash[:warning] = 'Username/password combination not found. Please try again.'
      render('new')
    end
  end

  def destroy
    logout_keeping_session!('user')
    flash[:warning] = 'You are now logged out.'
    redirect_to(login_path)
  end

  #--- Password Methods ---

  def forgot_password
    @hide_navigation = true
    # display form
  end

  def send_reset_token
    @user = User.where(email: params[:email], enabled: true).first
    if @user
      @user.email_reset_token
      flash[:warning] = 'Reset Link Sent'
      redirect_to login_path
    else
      flash[:warning] = 'Email address not found'
      render('forgot_password')
    end
  end

  def reset_password
    @user = User.find_by(password_token: params[:token])
    # NB: a blank params[:token] will find members without password_token
    if @user && @user.password_token.present?
      render('reset_password')
    else
      render('reset_password_failed')
    end
  end

  def update_password
    @user = User.find_by(password_token: params[:token])
    if @user
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      @user.password_token = nil
      if @user.save
        flash['primary'] = 'Password Successfully Reset'
        redirect_to root_path
      else
        render('reset_password')
      end
    else
      render('reset_password_failed')
    end
  end

  private

  def redirect_to_desired_url(_fallback_url = { action: 'index' })
    if session[:desired_url]
      desired_url = session[:desired_url]
      session[:desired_url] = nil
      redirect_to(root_path)
    else
      redirect_to(root_path)
    end
  end
end
