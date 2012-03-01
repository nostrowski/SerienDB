require 'spec_helper'

describe "series/index" do
  before(:each) do
    assign(:series, [
      stub_model(Series,
        :name => "Name",
        :added_by => 1,
        :edit_by => 1
      ),
      stub_model(Series,
        :name => "Name",
        :added_by => 1,
        :edit_by => 1
      )
    ])
  end
end
