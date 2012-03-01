class Series < ActiveRecord::Base
  has_many :seasons
  
  attr_reader :fullname_of_crator, :fullname_of_editor
  
  def fullname_of_creator
    User.find(added_by).fullname
  end
  
  def fullname_of_editor
    User.find(edit_by).fullname
  end
  
  def users_owning_series_complete
    [@aUser ||= User.first]
  end
  
  def users_owning_series_partly
    [@aUser ||= User.first]
  end
end
