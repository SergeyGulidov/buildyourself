require 'spec_helper'

describe "intervals/edit" do
  before(:each) do
    @interval = assign(:interval, stub_model(Interval,
      :interval_name => "MyString",
      :interval_slug => "MyString"
    ))
  end

  it "renders the edit interval form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", interval_path(@interval), "post" do
      assert_select "input#interval_interval_name[name=?]", "interval[interval_name]"
      assert_select "input#interval_interval_slug[name=?]", "interval[interval_slug]"
    end
  end
end
