# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'digest/sha1'

User.create(:login => "nijo", :password => Digest::SHA1.hexdigest('test123'), :email => 'spam@nijos.de', :firstname => 'Nils', :lastname => 'Ostrowski', :is_admin => true)
User.create(:login => "alex", :password => Digest::SHA1.hexdigest('test123'), :email => 'alex@nijos.de', :firstname => 'Alex', :lastname => 'Nassauer')

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