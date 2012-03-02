class User < ActiveRecord::Base
  has_and_belongs_to_many :seasons
  has_many :sessions
  
  def fullname
    @fullname ||= (firstname + " " + lastname)
  end
  
  def password_valid? password_to_check
    password == password_to_check
  end
end
