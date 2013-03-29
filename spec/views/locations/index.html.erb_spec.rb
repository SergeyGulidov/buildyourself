require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :city_lv => "City Lv",
        :city_ru => "City Ru",
        :country_lv => "Country Lv",
        :country_ru => "Country Ru",
        :slug => "Slug"
      ),
      stub_model(Location,
        :city_lv => "City Lv",
        :city_ru => "City Ru",
        :country_lv => "Country Lv",
        :country_ru => "Country Ru",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City Lv".to_s, :count => 2
    assert_select "tr>td", :text => "City Ru".to_s, :count => 2
    assert_select "tr>td", :text => "Country Lv".to_s, :count => 2
    assert_select "tr>td", :text => "Country Ru".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
