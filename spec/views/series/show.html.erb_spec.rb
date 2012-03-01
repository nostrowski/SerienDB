require 'spec_helper'

describe "series/show" do
  before(:each) do
    @series = assign(:series, stub_model(Series,
      :name => "Name",
      :added_by => 1,
      :edit_by => 1
    ))
  end
end
