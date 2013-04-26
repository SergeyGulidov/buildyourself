require 'spec_helper'

describe "requests/new" do
  before(:each) do
    assign(:request, stub_model(Request,
      :phone => 1,
      :address => "MyString",
      :when => "MyString"
    ).as_new_record)
  end

  it "renders new request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", requests_path, "post" do
      assert_select "input#request_phone[name=?]", "request[phone]"
      assert_select "input#request_address[name=?]", "request[address]"
      assert_select "input#request_when[name=?]", "request[when]"
    end
  end
end
