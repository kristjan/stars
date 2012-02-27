class ApplicationController < ActionController::Base
  before_filter :require_one_user
  before_filter :require_login
  before_filter :add_stylesheets

  helper :all
  helper_method :current_user

private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return User.first if ENV['IGNORE_CONNECT'] == 'true'
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_logout
    redirect_to root_path if (UserSession.find.user rescue false)
  end

  def require_login
    return if no_users?
    cookies[:redirect] = request.path
    redirect_to login_path unless current_user
  end

  def require_one_user
    redirect_to new_user_url if no_users?
  end

  def no_users?
    User.maximum(:id).nil?
  end

  def add_stylesheets
    @stylesheets = ['application']
  end

end
