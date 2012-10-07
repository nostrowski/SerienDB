class Season < ActiveRecord::Base
  belongs_to :series
  has_and_belongs_to_many :users
  has_and_belongs_to_many :tags
  
  def users_fullname
    return @users_fullname if @users_fullname
    @users_fullname = Array.new()
    users.each do |user|
      @users_fullname << user.fullname
    end
    return @users_fullname
  end
  
  def users_loginname_comma_list
    result = ""
    users.each do |user|
      result += user.login
      result += ", " unless user == users.last
    end
    return result
  end
  
  def removeable?
    if users.count == 0 || (users.count == 1 && users.include?(User.current)) then
      return true
    else
      return false
    end
  end
  
  def pilot?
    if number == 0 then
      return true
    else
      return false
    end
  end
  
  def name
    result = ""
    result << self.series.name
    result << (self.number!=0?"_s":"_Pilot")
    result << (self.number!=0?(self.number.to_s):"")
    return result
  end
  
  def is_filtered? filter
    if filter[:tag_id] == "" then
      t = true
    else
      t = false
      if filter[:tag_id] != "" && self.tags.include?(Tag.find_by_id(filter[:tag_id])) then
        t = true
      end
    end
    
    if filter[:owning] == "0" && filter[:not_owning] == "0" then
      x = true
    else
      x = false
      if filter[:owning] == "1" && users.include?(User.current) then
        x = true
      end
      if filter[:not_owning] == "1" && !users.include?(User.current) then
        x = true
      end
    end
     
    return !(x && t)
  end
  
# ===============
# = CSV support =
# ===============
  comma do
    name
    users_loginname_comma_list 'Besitzer'
  end
  
end