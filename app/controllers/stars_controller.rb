class StarsController < ApplicationController
  def index
    @stars = Star.recent(10)
    this_week = Date.today.beginning_of_week
    last_week = this_week - 1.week
    @current_superstars = User.superstars_for(this_week)
    @last_weeks_superstars = User.superstars_for(last_week, 5)
  end

  def show
    @star = Star.find(params[:id])
  end

  def new
    @star = Star.new
  end

  def edit
    @star = Star.find(params[:id])
  end

  def create
    @star = Star.new(params[:star])

    if @star.save
      flash[:notice] = "You starred #{@star.to.name}!"
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  def update
    @star = Star.find(params[:id])

    if @star.update_attributes(params[:star])
      redirect_to(@star)
    else
      render :action => "edit"
    end
  end

  def destroy
    @star = Star.find(params[:id])
    @star.destroy

    redirect_to(stars_path)
  end
end
