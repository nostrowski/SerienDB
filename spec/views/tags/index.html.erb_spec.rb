require 'spec_helper'

describe "tags/index" do
  before(:each) do
    assign(:tags, [
      stub_model(Tag,
        :acronym => "Acronym",
        :comment => "MyText",
        :color => "Color"
      ),
      stub_model(Tag,
        :acronym => "Acronym",
        :comment => "MyText",
        :color => "Color"
      )
    ])
  end

  it "renders a list of tags" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Acronym".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Color".to_s, :count => 2
  end
end
