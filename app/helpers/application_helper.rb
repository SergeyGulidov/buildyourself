module ApplicationHelper

	def current_lang_or_not(lang)
		if lang == I18n.locale.to_s
			return 'active'
		else
			return 'valid'
		end
		
	end

	  def full_title(page_title)
	    base_title = "Yoda.lv"
	    if page_title.empty?                             
	      base_title                                      
	    else
	      "#{base_title} | #{page_title}"                 
	    end
	  end
end
