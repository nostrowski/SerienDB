class Series < ActiveRecord::Base
  has_many :seasons
  has_and_belongs_to_many :tags
  
  validates_uniqueness_of :name, :case_sensitive => false
  
  def fullname_of_creator
    User.find(added_by).fullname
  end
  
  def fullname_of_editor
    User.find(edit_by).fullname
  end
  
  def pilot?
    has_pilot
  end
  
  def users_owning_series_complete
    build_owners_lists unless @owners_complete
    return @owners_complete
  end
  
  def users_owning_series_partly
    build_owners_lists unless @owners_partly
    return @owners_partly
  end
  
  def loginnames_owning_series_complete
    result = ""
    users_owning_series_complete.each do |user|
      result += user.login
      result += " "
    end
    return result
  end
  
  def loginnames_owning_series_partly
    result = ""
    users_owning_series_partly.each do |user|
      result += user.login
      result += " "
    end
    return result
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
    season = seasons.order("number DESC").first
    if season.removeable? && !season.pilot? then
      season.destroy
      update_editor!
      return true
    else
      return false
    end
  end
  
  def removeable?
    removeable = true
    seasons.each do |season|
      unless season.removeable? then
        removeable = false
        break
      end
    end
    return removeable
  end
  
  def last_season_pilot?
    season = seasons.order("number DESC").first
    return season.pilot?
  end
  
  def update_selected_seasons! params
    seasons.each do |season|
      season.users.delete(User.current)
      season.users << User.current if params["s#{season.number}"]
    end
    update_editor!
  end
  
  def update_attributes params
    had_an_error = false
    self.name = params[:name] if params[:name]
    self.has_pilot = params[:has_pilot] if params[:has_pilot]
    self.tag_ids = params[:tag_ids] if params[:tag_ids]
    self.added_by = params[:added_by] if params[:added_by]
    self.edit_by = params[:edit_by] if params[:edit_by]
    
    firstSeason = self.seasons.order("number ASC").first
    
    if self.pilot? then
      if firstSeason == nil || firstSeason.number != 0 then
        season = Season.new
        season.series = self
        season.number = 0
        season.added_by = User.current.id
        season.edit_by = User.current.id
        season.created_at = Time.now
        season.updated_at = Time.now
        season.save
      end
    else
      if firstSeason.number == 0 then
        if firstSeason.removeable? then
          firstSeason.destroy
        else
          had_an_error = true
          errors.add(:has_pilot, ': Entfernen der Pilotfolge nicht erlaubt! Pilotfolge hat noch Besitzer.')
        end
      end
    end
    
    self.save unless had_an_error
    return !had_an_error
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
  
# ===============
# = CSV support =
# ===============
  comma do
    name
    loginnames_owning_series_complete 'Komplettbesitzer'
    loginnames_owning_series_partly 'Teilbesitzer'
  end
end
