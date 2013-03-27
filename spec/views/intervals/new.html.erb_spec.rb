require 'spec_helper'

describe "intervals/new" do
  before(:each) do
    assign(:interval, stub_model(Interval,
      :interval_name => "MyString",
      :interval_slug => "MyString"
    ).as_new_record)
  end

  it "renders new interval form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", intervals_path, "post" do
      assert_select "input#interval_interval_name[name=?]", "interval[interval_name]"
      assert_select "input#interval_interval_slug[name=?]", "interval[interval_slug]"
    end
  end
end
