require 'spec_helper'

describe "intervals/show" do
  before(:each) do
    @interval = assign(:interval, stub_model(Interval,
      :interval_name => "Interval Name",
      :interval_slug => "Interval Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Interval Name/)
    rendered.should match(/Interval Slug/)
  end
end
