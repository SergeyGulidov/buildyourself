class CountriesController < ApplicationController
load_and_authorize_resource
	before_filter :find_country, :only => [:edit, :update, :destroy]
	
  def index
    @countries = Country.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @countriess }
    end
  end

  def new
  	@country = Country.new
  	respond_to do |format|
  		format.html  # new.html.erb
  		format.json  { render :json => @country }
  	end
  end

  def create
	  @country = Country.new(params[:country])
	  if @country.save
	    	redirect_to :action => 'new'
        	flash[:notice] = "country has added !"
	  else
	    	render :action => 'new'
	  end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @country.update_attributes(params[:country])
        format.html { redirect_to action: "index", notice: 'Country was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
   end	

  def destroy
    @country.destroy
    redirect_to action: "index"
  end

  def find_country
  	@country = Country.find(params[:id].to_i)
  end
end