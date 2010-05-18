class UserSessionsController < ApplicationController
  skip_before_filter :require_login
  before_filter :require_logout, :only => [:new, :create, :auth_fb_connect]

  def index
    redirect_to login_path
  end

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session ||= UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to(cookies[:redirect] || root_path)
      cookies[:redirect] = nil
    else
      render "new"
    end
  end

  def destroy
    current_user_session && current_user_session.destroy
    # Facebook
    if facebook_session
      clear_fb_cookies!
      clear_facebook_session_information
    end

    redirect_to login_path
  end

  def auth_fb_connect
    if facebook_session && facebook_session.user && !facebook_session.expired?
      @user = User.find_by_facebook_uid(facebook_session.user.id)
      if @user
        @user_session = UserSession.new(@user)
        create
      else
        # do something to validate user with facebook
      end
    else
      clear_fb_cookies!
      clear_facebook_session_information
      redirect_to root_path
    end
  end
end
