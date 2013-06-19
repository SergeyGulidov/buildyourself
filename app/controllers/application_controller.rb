class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale



  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied."
    redirect_to root_url
  end


  private
  	def set_locale
      if params[:locale].present? 
  		  I18n.locale = params[:locale] 
      else
        I18n.locale = 'lv'
  		#current_user.locale
      end
  	end

  	def default_url_options(options = {})
  		{locale: I18n.locale}
  	end
end
