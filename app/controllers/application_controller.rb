class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :set_locale

  before_filter :get_current_user_info


  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
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

    # get user info for login partial 
    def get_current_user_info
      if current_user
        @current_user_places ||= Place.order("created_at desc").where("user_id = ?", current_user.id).last(5)
        @current_user_posts  ||= Post.order("created_at desc").where("user_id = ?", current_user.id).last(5)
      end
    end
end
