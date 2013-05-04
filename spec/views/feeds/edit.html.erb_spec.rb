require 'spec_helper'

describe "feeds/edit" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed))
  end

  it "renders the edit feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feed_path(@feed), "post" do
    end
  end
end
