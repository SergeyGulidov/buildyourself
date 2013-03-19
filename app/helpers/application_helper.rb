module ApplicationHelper
	def current_lang_or_not(lang)
		if lang == @current_language
			return 'hide'
		end
	end

	  def full_title(page_title)
	    base_title = "Build Yourself"
	    if page_title.empty?                             
	      base_title                                      
	    else
	      "#{base_title} | #{page_title}"                 
	    end
	  end


end
