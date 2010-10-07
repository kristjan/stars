class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new(params[:team])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      flash[:notice] = "Team #{@team.name} created!"
      redirect_to teams_path
    else
      render :action => "new"
    end
  end

  def update
    @team = Team.find(params[:id])

    @team.user_ids = params[:team][:user_ids]
    @team.name     = params[:team][:name]
    @team.active   = params[:team][:active]

    if @team.save
      flash[:notice] = "Team #{@team.name} updated!"
      redirect_to teams_path
    else
      render :action => "new"
    end
  end

end
