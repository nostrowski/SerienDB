# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(:login => "nijo", :password => 'test123', :email => 'spam@nijos.de', :firstname => 'Nils', :lastname => 'Ostrowski')

Series.create(:name => 'Bones', :added_by => 1, :edit_by => 1)

s = Season.new(:series_id => 1, :number => 1, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

s = Season.new(:series_id => 1, :number => 2, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

s = Season.new(:series_id => 1, :number => 3, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save