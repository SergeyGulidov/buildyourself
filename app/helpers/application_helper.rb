module ApplicationHelper
	def current_lang_or_not(lang)
		if lang == @current_language
			return 'hide'
		end
	end
end
