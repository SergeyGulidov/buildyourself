module PlacesHelper

	def get_location(place)
		return "#{place.city.city_name}, #{place.country.country_name}"
	end

	def get_like_this(place)

		places = Place.approved
		same_type = {}

		place.types.each do |type|
            places = Place.joins(:types).where('types.type_slug' => 'type.type_slug')
        end

        return places
	end
end
