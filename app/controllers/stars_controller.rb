class StarsController < ApplicationController
  def index
    @users = User.by_recent_stars
    if @users.first.stars.any?
      @featured_user = @users.first
      @users = @users[1..-1]
    end
  end

  # GET /stars/1
  # GET /stars/1.xml
  def show
    @star = Star.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @star }
    end
  end

  # GET /stars/new
  # GET /stars/new.xml
  def new
    @star = Star.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @star }
    end
  end

  # GET /stars/1/edit
  def edit
    @star = Star.find(params[:id])
  end

  # POST /stars
  # POST /stars.xml
  def create
    @star = Star.new(params[:star])

    respond_to do |format|
      if @star.save
        format.html { redirect_to root_path }
        format.xml  { render :xml => @star, :status => :created, :location => @star }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @star.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stars/1
  # PUT /stars/1.xml
  def update
    @star = Star.find(params[:id])

    respond_to do |format|
      if @star.update_attributes(params[:star])
        format.html { redirect_to(@star) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @star.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stars/1
  # DELETE /stars/1.xml
  def destroy
    @star = Star.find(params[:id])
    @star.destroy

    respond_to do |format|
      format.html { redirect_to(stars_path) }
      format.xml  { head :ok }
    end
  end
end
