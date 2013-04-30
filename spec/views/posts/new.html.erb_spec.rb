require 'spec_helper'

describe "posts/new" do
  before(:each) do
    assign(:post, stub_model(Post,
      :title_ru => "MyString",
      :title_lv => "MyString",
      :message_lv => "MyText",
      :message_ru => "MyText",
      :author => "MyString",
      :image => "MyString"
    ).as_new_record)
  end

  it "renders new post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", posts_path, "post" do
      assert_select "input#post_title_ru[name=?]", "post[title_ru]"
      assert_select "input#post_title_lv[name=?]", "post[title_lv]"
      assert_select "textarea#post_message_lv[name=?]", "post[message_lv]"
      assert_select "textarea#post_message_ru[name=?]", "post[message_ru]"
      assert_select "input#post_author[name=?]", "post[author]"
      assert_select "input#post_image[name=?]", "post[image]"
    end
  end
end
