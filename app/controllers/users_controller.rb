class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path
    else
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.by_recent_stars
    if @users.first.stars.any?
      @featured_user = @users.first
      @users = @users[1..-1]
    end
  end

  def new
    @user = User.new
  end
end
