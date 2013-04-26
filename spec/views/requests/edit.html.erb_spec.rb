require 'spec_helper'

describe "requests/edit" do
  before(:each) do
    @request = assign(:request, stub_model(Request,
      :phone => 1,
      :address => "MyString",
      :when => "MyString"
    ))
  end

  it "renders the edit request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", request_path(@request), "post" do
      assert_select "input#request_phone[name=?]", "request[phone]"
      assert_select "input#request_address[name=?]", "request[address]"
      assert_select "input#request_when[name=?]", "request[when]"
    end
  end
end
