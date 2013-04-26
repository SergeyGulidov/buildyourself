require 'spec_helper'

describe "requests/index" do
  before(:each) do
    assign(:requests, [
      stub_model(Request,
        :phone => 1,
        :address => "Address",
        :when => "When"
      ),
      stub_model(Request,
        :phone => 1,
        :address => "Address",
        :when => "When"
      )
    ])
  end

  it "renders a list of requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "When".to_s, :count => 2
  end
end
