require 'spec_helper'

describe Season do
  before() do
    User.create(:login => "nijo", :password => Digest::SHA1.hexdigest('test123'), :email => 'spam@nijos.de', :firstname => 'Nils', :lastname => 'Ostrowski', :is_admin => true)
    User.create(:login => "alex", :password => Digest::SHA1.hexdigest('test123'), :email => 'alex@nijos.de', :firstname => 'Alex', :lastname => 'Nassauer')
    
    Series.create(:name => 'Bones', :added_by => 1, :edit_by => 1)
    
    s = Season.new(:number => 1, :added_by => 1, :edit_by => 1)
    s.users << User.first
    s.users << User.last
    s.series = Series.first
    s.save
  end
  
  it "all users fullnames should be returned as array" do
    the_array = Array.new()
    the_array << "Nils Ostrowski"
    the_array << "Alex Nassauer"
    Season.first.users_fullname.should == the_array
  end
  
  it "season should not be removable" do
    Season.first.removeable?.should == false
  end
end
