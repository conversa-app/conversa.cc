# frozen_string_literal: true

module SessionMethods
  protected

  def admin_logged_in?
    if current_user(Admin)
      true
    else
      false
    end
  end

  def user_logged_in?
    if current_user(User)
      true
    else
      false
    end
  end

  def current_user(klass = Admin)
    return if @current_user == false

    class_name = get_klass_name(klass)
    @current_user ||= (login_from_session(klass) || login_from_cookie(klass))
    instance_variable_set("@current_#{class_name}".to_sym, @current_user)
    @current_user
  end

  def current_user=(new_user)
    session["#{get_klass_name(new_user)}_id".to_sym] = new_user ? new_user.id : nil
    yield if block_given?
    @current_user = new_user || false
  end

  def current_admin=(admin)
    session[:admin_id] = admin ? admin.id : nil
    @current_admin = admin || false
  end

  def login_from_session(klass)
    class_name = get_klass_name(klass)
    user = klass.find_by(id: session["#{class_name}_id".to_sym])
    return unless user

    if user.enabled
      self.current_user = user
    else
      logout_keeping_session!(class_name)
    end
  end

  def login_from_cookie(klass)
    class_name = get_klass_name(klass)
    auth_token = "#{class_name}_auth_token".to_sym
    user = klass.find_by(remember_token: cookies[auth_token]) if cookies[auth_token]
    if user&.remember_token?
      if user.enabled
        self.current_user = user
        handle_remember_cookie!(false, klass) # freshen cookie token (keeping date)
        return current_user
      else
        logout_keeping_session!(class_name)
      end
    end
  rescue StandardError
    logout_killing_session!(class_name)
  end

  # The session should only be reset at the tail end of a form POST --
  # otherwise the request forgery protection fails. It's only really necessary
  # when you cross quarantine (logged-out to logged-in).
  def logout_killing_session!(class_name)
    logout_keeping_session!(class_name)
    reset_session
  end

  def logout_keeping_session!(class_name)
    # Kill server-side auth cookie
    @current_user.try(:forget_me)
    @current_user = false
    kill_remember_cookie!(class_name) # Kill client-side auth cookie
    session["#{class_name}_id".downcase.to_sym] = nil
    # explicitly kill any other session variables you set
  end

  def kill_remember_cookie!(class_name)
    cookies.delete "#{class_name}_auth_token".to_sym
  end

  def valid_remember_cookie?(class_name)
    return nil unless @current_user

    @current_user.remember_token? &&
      (cookies["#{class_name}_auth_token".to_sym] == @current_user.remember_token)
  end

  # Refresh the cookie auth token if it exists, create it otherwise
  def handle_remember_cookie!(new_cookie_flag, klass)
    class_name = get_klass_name(klass)
    return unless @current_user
    if new_cookie_flag
      @current_user.remember_me 
    else
      @current_user.refresh_token if valid_remember_cookie?(class_name) # keeping same expiry date
    end
    @current_user.reload
    cookie_options = {
      value: @current_user.remember_token,
      expires: @current_user.remember_token_expires_at
    }
    write_cookie!(klass, cookie_options)
  end

  def get_klass_name(klass)
    klass.respond_to?(:name) ? klass.name.tableize.singularize : klass.class.name.tableize.singularize
  end

  def write_cookie!(klass, options)
    class_name = get_klass_name(klass)
    cookie_name = "#{class_name}_auth_token".to_sym
    cookie_hash = {
      path: klass.try(:cookie_path) ? klass.cookie_path : '/',
      secure: %w[development test].include?(Rails.env) ? false : true,
      httponly: true
    }
    cookie_hash.merge!(options)
    cookies[cookie_name] = cookie_hash
  end
end
