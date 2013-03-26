class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :set_locale



 def index
    set_search_place
 end

 def show
    set_search_place
 end

 def edit
    set_search_place
 end

 def approve
    set_search_place
  end

  def make_approve
    set_search_place
  end







  def set_search_place
      puts @city_for_filter
      places = Place.where(approved: 1)
      @search = places.with_translations(I18n.locale).search(params[:q])
      @places = @search.result
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end


  private

  	def set_locale
  		I18n.locale = params[:locale] if params[:locale].present?
  		#current_user.locale
  	end

  	def default_url_options(options = {})
  		{locale: I18n.locale}
  	end
end
