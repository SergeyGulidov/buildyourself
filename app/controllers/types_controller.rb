class TypesController < ApplicationController
	load_and_authorize_resource
	before_filter :find_type, :only => [:show, :edit, :update, :destroy]
	
  def new
  	@type = Type.new
	respond_to do |format|
		format.html  # new.html.erb
		format.json  { render :json => @type }
	end
  end

  def create
	  @type = Type.new(params[:type])
	  if @type.save
	    	redirect_to :action => 'new'
        	flash[:notice] = "Type has added !"
	  else
	    	render :action => 'new'
	  end
  end

  def show
	places = @type.places.where(approved: 1)
	#@places = @type.places.page(params[:page]).per(5)
	@places = places.page(params[:page]).per(5)
	@json = places.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
  		end

  end

  def edit
  end

  def analize
  	@types = Type.all
  end

  def update
	      if @type.update_attributes(params[:type])
	         redirect_to :action => 'analize'
	      else
	         @type = type.find(params[:id])
	         render :action => 'edit'
      		end
   end	

  def destroy
    @type.destroy
    redirect_to :action => 'analize'
  end

  def find_type
  	@type = Type.find(params[:id].to_i)
  end


def gmaps4rails_marker_picture
    {
    "picture" => "http://maps.google.com/mapfiles/ms/micons/blue.png",
    "width" => 32,
    "height" => 32
    }
end


end
