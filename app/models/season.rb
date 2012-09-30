class Season < ActiveRecord::Base
  belongs_to :series
  has_and_belongs_to_many :users
  
  def users_fullname
    return @users_fullname if @users_fullname
    @users_fullname = Array.new()
    users.each do |user|
      @users_fullname << user.fullname
    end
    return @users_fullname
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
  
end