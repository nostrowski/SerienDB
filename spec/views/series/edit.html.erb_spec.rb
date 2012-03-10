require 'spec_helper'

describe "series/edit" do
  before(:each) do
    @series = assign(:series, stub_model(Series,
      :name => "MyString",
      :added_by => 1,
      :edit_by => 1
    ))
  end

  it "renders the edit series form" do
    pending
    
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => series_index_path(@series), :method => "post" do
      assert_select "input#series_name", :name => "series[name]"
      assert_select "input#series_added_by", :name => "series[added_by]"
      assert_select "input#series_edit_by", :name => "series[edit_by]"
    end
  end
end
