require 'digest/sha1'

class User < ActiveRecord::Base
  has_and_belongs_to_many :seasons
  has_many :sessions
  
  # validates_confirmation_of :password_clear
  # attr_accessible :password_clear, :password_clear_confirmation
  # attr_accessor :password_clear, :password_clear_confirmation
  
  def self.set_current user
    @current_user = user
  end
  
  def self.current
    @current_user
  end
  
  def fullname
    @fullname ||= (firstname + " " + lastname)
  end
  
  def password_valid? clear_password
    password == hash_password(clear_password)
  end
  
  def hash_password clear_password
    Digest::SHA1.hexdigest(clear_password)
  end
  
  def admin?
    is_admin
  end
  
  def update_attributes params
    had_an_error = false
    unless params[:password] == params[:password_confirmation] then
      errors.add(:password, ': "Passwort" und "Passwort wiederholen" nicht identisch!')
      had_an_error = true
    else
      self.password = hash_password(params[:password]) unless params[:password] == ""
    end
    
    self.login = params[:login] if params[:login]
    self.email = params[:email] if params[:email]
    self.firstname = params[:firstname] if params[:firstname]
    self.lastname = params[:lastname] if params[:lastname]
    self.is_admin = params[:is_admin] if params[:is_admin]
    
    self.save unless had_an_error
    return !had_an_error
  end
end
