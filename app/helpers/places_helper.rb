module PlacesHelper

	def get_location(place)
		return "#{place.country.country_name}, #{place.city.city_name}"
	end

	def get_like_this(place)

		places = Place.approved
		same_type = {}

		place.types.each do |type|
            places = Place.joins(:types).where('types.type_slug' => 'type.type_slug')
        end

        return places
	end

	def get_keywords(place)
		keys = ""
		place.categories.each do |category|
			keys += category.category_name.to_s + ", "
		end
		place.types.each do |type|
			keys += type.type_name.to_s + ", "
		end
		keys +=  @place.city.city_name.to_s
		return keys
	end

end
