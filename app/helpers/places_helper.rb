module PlacesHelper

	def get_location(place)
		place.locations.each do |location|
	     return "#{location.city}, #{location.country}"
		end
	end

end
