require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title_ru => "Title Ru",
      :title_lv => "Title Lv",
      :message_lv => "MyText",
      :message_ru => "MyText",
      :author => "Author",
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title Ru/)
    rendered.should match(/Title Lv/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Author/)
    rendered.should match(/Image/)
  end
end
