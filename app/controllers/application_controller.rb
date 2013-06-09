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

    def locale_changed?
      if params[:change_locale].present?
        expire_fragment('footer')
        expire_fragment('about')
        expire_fragment('blog_posts')
      end 
    end

    # get user info for login partial 
    def get_current_user_info
      if current_user
          @current_user_places ||= Place.select("name, approved, slug, id")
            .order("created_at desc").where("user_id = ?", current_user.id).last(10)

          @current_user_posts  ||= Post.select("title_lv, title_ru, approved, id")
            .order("created_at desc").where("user_id = ?", current_user.id).last(10)
      end
    end
end
