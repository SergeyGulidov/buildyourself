class PlacesController < ApplicationController
load_and_authorize_resource

	before_filter :get_filter_collections
	
	respond_to :html, :xml, :json, :js

	def index
		unless params[:search].blank?
			@places = Place.search(params)
			@json = get_json_for_map(@places)
		else
			places, @type_vip, watcher = Place.first_step_search(params)
			if watcher == 0
				@places = places.page(params[:page]).per(3)
			else
				@json = get_json_for_map(places)
				@places = places.page(params[:page]).per(5)
			end
		end
		@recent_posts = Post.recent

		if @places.blank?
			flash[:alert] = t(:nothing_found) 
		else
			flash[:alert] = nil
		end
	end

	def new
		@place = Place.new 
		respond_to do |format|
	      format.html
	      format.json { render json: @post }
	    end
	end

	def create
	  @place = Place.new(params[:place])
	  @place.user_id = current_user.id

	  respond_to do |format|
	    if @place.save
		    format.html  { redirect_to(@place, :notice => t(:new_place_success)) }
	      	format.json  { render :json => @place, :status => :created, :location => @place }
	    else
	      format.html  { render :action => "new" }
	      format.json  { render :json => @place.errors,
	                    :status => :unprocessable_entity }
	    end
	  end
	end

	def show
		@place = Place.includes(:user, :schedules, :feeds, :photos).order("created_at desc").find(params[:id])
		@user_posts ||= Post.where(user_id: @place.user_id).order("created_at desc").limit(5)

		@other_user_places = Place.other_user_places.where("id != ? AND user_id = ?", @place.id, @place.user_id )
		
		@subscriber = Subscriber.new

		if current_user and current_user.id == @place.user_id
		   @feed = Feed.new
		   @schedule = Schedule.new
		end

		@json = get_json_for_map(@place)
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
		@places = Place.where(approved: 0).order("created_at asc")
		@places = @places.page(params[:page]).per(10)
	end

	def make_approve
		@place = Place.find(params[:id])
		@json = get_json_for_map(@place)
	end

	def destroy
	  	@place = Place.find(params[:id].to_i)
	    @place.destroy
	    redirect_to action: "approve", notice: 'Place was successfully destroyed.'
	end

	def translate
		@places = Place.includes(:photos).where(translated: 0, approved: 1)
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

end
