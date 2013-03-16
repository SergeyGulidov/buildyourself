class PlacesController < ApplicationController

	def index
	  @places = Place.all
	  @json = Place.all.to_gmaps4rails
	end

  def home
  	@place = Place.find(params[:id])
 
	  respond_to do |format|
	    format.html  # show.html.erb
	    format.json  { render :json => @place }
	  end
  end

  def new
  	@place = Place.new
	 
	respond_to do |format|
		format.html  # new.html.erb
		format.json  { render :json => @place }
	end
  end

  def create
	  @place = Place.new(params[:place])
	  respond_to do |format|
	    if @place.save
	      format.html  { redirect_to(@place,
	                    :notice => 'Place was successfully created.') }
	      format.json  { render :json => @place,
	                    :status => :created, :location => @place }
	    else
	      format.html  { render :action => "new" }
	      format.json  { render :json => @place.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
  end

  def contact
  end

  def show
	@place = Place.find(params[:id])
	@json = Place.find(params[:id]).to_gmaps4rails
  end

  def edit
      @place = Place.find(params[:id])
   end

      def update
      	@place = Place.find(params[:id])
	      if @place.update_attributes(params[:place])
	         redirect_to :action => 'show', :id => @place
	      else
	         @place = Place.find(params[:id])
	         render :action => 'edit'
      end
   end
end
