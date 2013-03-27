require 'spec_helper'

describe "intervals/index" do
  before(:each) do
    assign(:intervals, [
      stub_model(Interval,
        :interval_name => "Interval Name",
        :interval_slug => "Interval Slug"
      ),
      stub_model(Interval,
        :interval_name => "Interval Name",
        :interval_slug => "Interval Slug"
      )
    ])
  end

  it "renders a list of intervals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Interval Name".to_s, :count => 2
    assert_select "tr>td", :text => "Interval Slug".to_s, :count => 2
  end
end
