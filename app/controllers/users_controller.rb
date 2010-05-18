class UsersController < ApplicationController
  def index
    @users = User.by_recent_stars
    if @users.first.stars.any?
      @featured_user = @users.first
      @users = @users[1..-1]
    end
  end
end
