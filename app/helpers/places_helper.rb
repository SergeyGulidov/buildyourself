module PlacesHelper

	def get_location(place)
		place.locations.each do |location|
	     return "#{location.city}, #{location.country}"
		end
	end

	def get_like_this(place)

		places = Place.approved
		same_type = {}

		place.types.each do |type|
            places = places.joins(:types).where('types.type_slug' => 'type.type_slug')
        end

        return places
	end
end
