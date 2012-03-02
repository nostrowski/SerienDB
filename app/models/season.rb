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
end