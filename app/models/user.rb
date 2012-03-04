class User < ActiveRecord::Base
  has_and_belongs_to_many :seasons
  has_many :sessions
  
  def self.set_current user
    @current_user = user
  end
  
  def self.current
    @current_user
  end
  
  def fullname
    @fullname ||= (firstname + " " + lastname)
  end
  
  def password_valid? password_to_check
    password == password_to_check
  end
  
  def admin?
    is_admin
  end
end
