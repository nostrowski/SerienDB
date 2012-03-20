require 'spec_helper'

describe "tags/edit" do
  before(:each) do
    @tag = assign(:tag, stub_model(Tag,
      :acronym => "MyString",
      :comment => "MyText",
      :color => "MyString"
    ))
  end

  it "renders the edit tag form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tags_path(@tag), :method => "post" do
      assert_select "input#tag_acronym", :name => "tag[acronym]"
      assert_select "textarea#tag_comment", :name => "tag[comment]"
      assert_select "input#tag_color", :name => "tag[color]"
    end
  end
end
