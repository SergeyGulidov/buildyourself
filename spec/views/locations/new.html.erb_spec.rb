require 'spec_helper'

describe "locations/new" do
  before(:each) do
    assign(:location, stub_model(Location,
      :city_lv => "MyString",
      :city_ru => "MyString",
      :country_lv => "MyString",
      :country_ru => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", locations_path, "post" do
      assert_select "input#location_city_lv[name=?]", "location[city_lv]"
      assert_select "input#location_city_ru[name=?]", "location[city_ru]"
      assert_select "input#location_country_lv[name=?]", "location[country_lv]"
      assert_select "input#location_country_ru[name=?]", "location[country_ru]"
      assert_select "input#location_slug[name=?]", "location[slug]"
    end
  end
end
