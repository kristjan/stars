class UsersController < ApplicationController
  skip_before_filter :require_one_user, :only => [:new, :create]

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
    @users = User.all.sort_by(&:name)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @star = Star.new(:to => [@user])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path
    else
      render :action => :edit
    end
  end
end
