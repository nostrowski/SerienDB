class Series < ActiveRecord::Base
  has_many :seasons
  
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
  
  def update_editor!
    self.updated_at = Time.now
    self.edit_by = User.current.id
    self.save
  end
  
  def add_season!
    last_number = 0
    seasons.each do |season|
      last_number = season.number if last_number < season.number
    end
    Season.create(:series_id => id, :number => last_number+1)
    update_editor!
  end
  
  def remove_last_season!
    delete_number = 0
    seasons.each do |season|
      delete_number = season.number if delete_number < season.number
    end
    
    season = seasons.find_by_number(delete_number)
    
    if season.users_fullname.count == 0 || (season.users_fullname.count == 1 && season.users_fullname.include?(current_user.fullname)) then
      season.destroy
      update_editor!
      return true
    else
      return false
    end
  end
  
  def update_selected_seasons! params
    seasons.each do |season|
      season.users.delete(User.current)
      season.users << User.current if params["s#{season.number}"]
    end
    update_editor!
  end
end
