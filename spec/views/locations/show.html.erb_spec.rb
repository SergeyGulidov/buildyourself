require 'spec_helper'

describe "locations/show" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :city_lv => "City Lv",
      :city_ru => "City Ru",
      :country_lv => "Country Lv",
      :country_ru => "Country Ru",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/City Lv/)
    rendered.should match(/City Ru/)
    rendered.should match(/Country Lv/)
    rendered.should match(/Country Ru/)
    rendered.should match(/Slug/)
  end
end
