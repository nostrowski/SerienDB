require 'spec_helper'

describe User do
  before(:each) do
    @nils = User.new(:login => "nijo", :password => 'test123', :email => 'spam@nijos.de', :firstname => 'Nils', :lastname => 'Ostrowski')
  end
  
  it "fullname should be: Nils Ostrowski" do
    @nils.fullname.should == "Nils Ostrowski"
  end
  
end
