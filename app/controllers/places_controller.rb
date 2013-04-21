class PlacesController < ApplicationController
load_and_authorize_resource

	before_filter :get_current_user_places, :only => [:index, :home, :new, :edit, :show]
	respond_to :html, :xml, :json

	def index
		unless params[:search].blank?
			@places = Place.search(params)
			@json = get_json_for_map(@places)
		else
			@places, @type_vip = Place.first_step_search(params)
			@json = get_json_for_map(@places)
			@places = @places.page(params[:page]).per(10)
		end

		if @places.blank?
			flash[:alert] = t(:nothing_found) 
		else
			flash[:alert] = nil
		end
	end

	def new
		@place = Place.new 
		flash.now[:notice] = t(:register_first) unless current_user
		respond_with(@place)
	end

	def create
	  @place = Place.new(params[:place])

	  respond_to do |format|
	    if @place.save
		  if current_user

		    format.html  { redirect_to(@place,
            	:notice => t(:new_place_success)) }
	      	format.json  { render :json => @place,
	            :status => :created, :location => @place }
		  else
		  	flash[:alert] = t(:new_place_success)
		    format.html  { redirect_to action: 'new' }
		  end
	    else
	      format.html  { render :action => "new" }
	      format.json  { render :json => @place.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
	end

	def show
		@place = Place.includes(:user).find(params[:id])
		@json = @place.to_gmaps4rails do |place, marker|
			    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
			    marker.title "#{place.name}"
		end
		@place.hits += 1
		@place.save
	end

	def edit
		@place = Place.find(params[:id])
		@json = @place.to_gmaps4rails do |place, marker|
		    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
		    marker.title "#{place.name}"
		end
	end

	  def update
	  	@place = Place.find(params[:id])
	  	@place.approved = 0
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
		  redirect_to :back, notice: t(:vote_thanks)
		else
		  redirect_to :back, alert: t(:vote_already_did)
		end
	end

	def approve
		places = Place.where(approved: 0)
		@places = places.page(params[:page]).per(10)

		@json = places.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
		end
	end

	def make_approve
		@place = Place.find(params[:id])
		@json = @place.to_gmaps4rails do |place, marker|
		    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
		    marker.title "#{place.name}"
		end
	end


	def get_current_user_places
		@current_user_places ||= Place.where("user_id = ?", current_user.id ) if current_user
	end


	def get_json_for_map(places)
		json = places.to_gmaps4rails do |place, marker|
		    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
		    marker.title "#{place.name}"
		end
		return json
	end


  def destroy
  	@place = Place.find(params[:id].to_i)
    @place.destroy
    redirect_to action: "approve", notice: 'Place was successfully destroyed.'
  end


	def translate
		places = Place.includes(:photos).where(translated: 0)
		@places = places.page(params[:page]).per(10)

		@json = places.to_gmaps4rails do |place, marker|
	    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
	    marker.title "#{place.name}"
		end
	end

	def make_translate
		@place = Place.find(params[:id])
		@json = @place.to_gmaps4rails do |place, marker|
		    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
		    marker.title "#{place.name}"
		end
	end



end
