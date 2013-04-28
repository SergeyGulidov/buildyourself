class PlacesController < ApplicationController
load_and_authorize_resource

	before_filter :get_current_user_places, :only => [:index, :home, :new, :edit, :show, :create, :update ]
	before_filter :get_filter_collections,  :only => [:index, :edit, :show, :new, :make_approve, :create, :update ]
	before_filter :get_recent_added,  :only => [:index, :edit, :show, :new, :approve, :translate, :create, :update ]
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
	  @place.user_id = current_user.id

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
		@photos = @place.photos.all
		@place = Place.includes(:user).find(params[:id])
		@json = get_json_for_map(@place)
		@place.hits += 1
		@place.save
	end

	def edit
		@place = Place.find(params[:id])
		@json = get_json_for_map(@place)
	end

	  def update
	  	@place = Place.find(params[:id])
	      if @place.update_attributes(params[:place])
	         redirect_to :action => 'show', :id => @place
	      else
	         @place = Place.find(params[:id])
	         redirect_to :back
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
		@places = Place.where(approved: 0)
		@json = get_json_for_map(@places)
		@places = @places.page(params[:page]).per(10)
	end

	def make_approve
		@place = Place.find(params[:id])
		@json = get_json_for_map(@place)
	end

	# get user places for login partial 
	def get_current_user_places 
		@current_user_places ||= Place.where("user_id = ?", current_user.id ).all if current_user
	end


	def destroy
	  	@place = Place.find(params[:id].to_i)
	    @place.destroy
	    redirect_to action: "approve", notice: 'Place was successfully destroyed.'
	end


	def translate
		@places = Place.includes(:photos).where(translated: 0, approved: 1)
		@json = get_json_for_map(@places)
		@places = @places.page(params[:page]).per(10)
	end

	def make_translate
		@place = Place.find(params[:id])
		@json = get_json_for_map(@place)
	end

	def get_filter_collections
		@categories ||= Category.categories_all
		@cities 	||= City.cities_all
		@countries  ||= Country.countries_all
		@types      ||= Type.types_all
	end

	def get_json_for_map(places)
		json = places.to_gmaps4rails do |place, marker|
		    marker.infowindow render_to_string(:partial => "/shared/infowindow", :locals => { :place => place})
		    marker.title "#{place.name}"
		end
		return json
	end

	def get_recent_added
		@recent_added ||= Place.recent
	end

end
