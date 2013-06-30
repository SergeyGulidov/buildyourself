class Byway < ActiveRecord::Base
  attr_accessible :city_id, :country_id, :gmaps, :latitude, :longitude, :place_id, :street, :user_id
  belongs_to :city
  belongs_to :place
  belongs_to :country

  acts_as_gmappable

	def gmaps4rails_address
	#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
	  "#{self.street}, #{self.city.city_name_lv}, #{self.country.country_name_lv}" 
	end
end
