class StarsController < ApplicationController
  def index
    @stars = Star.recent(5)
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
