require 'spec_helper'
require 'digest/sha1'

describe User do
  before() do
    User.create(:id => 1, :login => "nijo", :password => Digest::SHA1.hexdigest('test123'), :email => 'spam@nijos.de', :firstname => 'Nils', :lastname => 'Ostrowski', :is_admin => true)
    User.create(:id => 2, :login => "alex", :password => Digest::SHA1.hexdigest('test123'), :email => 'alex@nijos.de', :firstname => 'Alex', :lastname => 'Nassauer')
  end
  
  it "fullname should be: Nils Ostrowski" do
    User.first.fullname.should == "Nils Ostrowski"
  end
  
  it "password_valid?('test123') should be true" do
    User.first.password_valid?('test123').should. == true
  end
  
  it "password_valid?('blabla') should be false" do
    User.first.password_valid?('blabla').should == false
  end
  
  it "User.first should be admin" do
    User.first.admin?.should == true
  end
  
  it "User.last should not be admin" do
    User.last.admin?.should == false
  end
  
  it "setting the current user and reading it" do
    User.set_current User.first
    User.current.should == User.first
  end
  
  it "resetting of attributes test (with update_attributes metthod)" do
    pending
  end
  
end
