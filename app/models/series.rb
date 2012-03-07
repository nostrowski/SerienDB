class Series < ActiveRecord::Base
  has_many :seasons
  
  def fullname_of_creator
    User.find(added_by).fullname
  end
  
  def fullname_of_editor
    User.find(edit_by).fullname
  end
  
  def users_owning_series_complete
    build_owners_lists unless @owners_complete
    return @owners_complete
  end
  
  def users_owning_series_partly
    build_ownlers_lists unless @owners_partly
    return @owners_partly
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
    
    if season.users_fullname.count == 0 || (season.users_fullname.count == 1 && season.users_fullname.include?(User.current.fullname)) then
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
  
  private
  
  def build_owners_lists
    @owners_complete = Array.new
    @owners_partly = Array.new
    
    User.all.each do |user|
      has_a_season = false
      has_a_season_not = false
      seasons.each do |season|
        if user.seasons.include?(season) then
          has_a_season = true
        else
          has_a_season_not = true
        end
      end
      @owners_complete << user if has_a_season == true && has_a_season_not == false
      @owners_partly << user if has_a_season == true && has_a_season_not == true
    end
  end
end
