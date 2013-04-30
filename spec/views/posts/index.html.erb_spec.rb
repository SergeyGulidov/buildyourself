require 'spec_helper'

describe "posts/index" do
  before(:each) do
    assign(:posts, [
      stub_model(Post,
        :title_ru => "Title Ru",
        :title_lv => "Title Lv",
        :message_lv => "MyText",
        :message_ru => "MyText",
        :author => "Author",
        :image => "Image"
      ),
      stub_model(Post,
        :title_ru => "Title Ru",
        :title_lv => "Title Lv",
        :message_lv => "MyText",
        :message_ru => "MyText",
        :author => "Author",
        :image => "Image"
      )
    ])
  end

  it "renders a list of posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title Ru".to_s, :count => 2
    assert_select "tr>td", :text => "Title Lv".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
