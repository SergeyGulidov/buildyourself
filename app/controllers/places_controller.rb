class PlacesController < ApplicationController
load_and_authorize_resource

	
	def index
		
		@places = Place.search(params)

		@json = @places.to_gmaps4rails do |place, marker|
			    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
			    marker.title "#{place.name}"
	  	end

		@places = @places.page(params[:page]).per(5)

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
	  if current_user
	  	@place.user_id = current_user.id 
	  else
	  	@place.user_id = 7  # admin id by default
	  end

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
  
  def show
  	@places = super
	@place = Place.find(params[:id])
	@json = @place.to_gmaps4rails do |place, marker|
		    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
		    marker.title "#{place.name}"
  		end
  end

  def edit
  		@places = super
      @place = Place.find(params[:id])
      @json = @place.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
  		end
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

  def vote
    vote = current_user.place_votes.new(value: params[:value], place_id: params[:id].to_i)
    if vote.save
      redirect_to :back, notice: "Thank you for voting."
    else
      redirect_to :back, alert: "Unablet to vote, perhaps you already did."
    end
  end

  def approve

  	places = Place.where(approved: 0)
  	@places = places.page(params[:page]).per(5)

  	@json = places.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
  	end
  end

  def make_approve

  	@places = super
  	@place = Place.find(params[:id])
      @json = @place.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
  		end
  end




end
