module PlacesHelper

	def get_location(place)
		return "#{place.country.country_name}, #{place.city.city_name}"
	end


	def get_keywords(place)
		keys = ""
		keys += place.category.category_name.to_s + ", "
		keys += place.type.type_name.to_s + ", "
		keys += place.city.city_name.to_s
		return keys
	end

end
