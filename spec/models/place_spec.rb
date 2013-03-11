require 'spec_helper'

describe Place do
  	it 'is invalid without body or title' do
		place = Place.new()
		place.should be_valid
	end

	it 'is valid with body and title' do
		place = Place.new(message: "Some cool text", name: "Some title")
		place.should be_valid
	end
end
