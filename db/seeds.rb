# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'digest/sha1'

#Users
User.create(:login => "nijo", :password => Digest::SHA1.hexdigest('test123'), :email => 'spam@nijos.de', :firstname => 'Nils', :lastname => 'Ostrowski', :is_admin => true, :replace_uncomplete_x => true)
User.create(:login => "alex", :password => Digest::SHA1.hexdigest('test123'), :email => 'alex@nijos.de', :firstname => 'Alex', :lastname => 'Nassauer')
User.create(:login => "rafi", :password => Digest::SHA1.hexdigest('test123'), :email => 'rw@nijos.de', :firstname => 'Rafael', :lastname => 'Wunderwald')

#Tags
Tag.create(:acronym => 'C', :comment => "(Complete) Produktion eingestellt", :color => "green", :priority => "2")
Tag.create(:acronym => 'C', :comment => "(Complete) Wird noch produziert, neue Staffeln jedoch nicht mehr in Deutsch", :color => "orange", :priority => "1")

#Series
s = Series.new(:name => 'Bones', :added_by => 1, :edit_by => 1)
s.tags << Tag.last
s.save

s = Series.new(:name => 'Battlestar Galactica', :has_pilot => true, :added_by => 1, :edit_by => 1)
s.tags << Tag.first
s.save

#Seasons
s = Season.new(:series_id => 1, :number => 1, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

s = Season.new(:series_id => 1, :number => 2, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

s = Season.new(:series_id => 1, :number => 3, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

s = Season.new(:series_id => 2, :number => 0, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

s = Season.new(:series_id => 2, :number => 1, :added_by => 1, :edit_by => 1)
s.users << User.first
s.save

Season.create(:series_id => 2, :number => 2, :added_by => 1, :edit_by => 1)
Season.create(:series_id => 2, :number => 3, :added_by => 1, :edit_by => 1)
