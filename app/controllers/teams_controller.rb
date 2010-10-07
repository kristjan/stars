class TeamsController < ApplicationController

  def index
    @teams ||= {}
    @teams[:active]   = Team.all.group_by(&:active?)[true]
    @teams[:inactive] = Team.all.group_by(&:active?)[false]
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
    @team.active   = params[:active]

    if @team.save
      flash[:notice] = "Team #{@team.name} updated!"
      redirect_to teams_path
    else
      render :action => "new"
    end
  end

end
