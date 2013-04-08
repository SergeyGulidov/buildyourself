class CitiesController < ApplicationController
load_and_authorize_resource
	before_filter :find_city, :only => [:edit, :update, :destroy]
	
  def index
    @cities = City.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @citys }
    end
  end

  def new
  	@city = City.new
  	respond_to do |format|
  		format.html  # new.html.erb
  		format.json  { render :json => @city }
  	end
  end

  def create
	  @city = City.new(params[:city])
	  if @city.save
	    	redirect_to :action => 'new'
        	flash[:notice] = "city has added !"
	  else
	    	render :action => 'new'
	  end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @city.update_attributes(params[:city])
        format.html { redirect_to action: "index", notice: 'City was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
   end	

  def destroy
    @city.destroy
    redirect_to action: "index"
  end

  def find_city
  	@city = City.find(params[:id].to_i)
  end
end