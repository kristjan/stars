class UserSessionsController < ApplicationController
  skip_before_filter :require_login
  before_filter :require_logout, :only => [:new, :create]

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
    redirect_to login_path
  end
end
