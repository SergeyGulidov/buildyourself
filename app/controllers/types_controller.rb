class TypesController < ApplicationController
	load_and_authorize_resource
	
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
	@type = Type.find(params[:id])
	@places = @type.places.page(params[:page]).per(5)

	@json = @type.places.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
	    marker.picture({:picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=A|FF0000|000000",
	                    :width => 32,
	                    :height => 32})
  		end

  end

  def edit
  	@types = Type.all
  end



end
