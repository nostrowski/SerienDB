require 'spec_helper'

describe "tags/new" do
  before(:each) do
    assign(:tag, stub_model(Tag,
      :acronym => "MyString",
      :comment => "MyText",
      :color => "MyString"
    ).as_new_record)
  end

  it "renders new tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tags_path, :method => "post" do
      assert_select "input#tag_acronym", :name => "tag[acronym]"
      assert_select "textarea#tag_comment", :name => "tag[comment]"
      assert_select "input#tag_color", :name => "tag[color]"
    end
  end
end
