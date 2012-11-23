require 'digest/sha1'

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
  
  def password_valid? clear_password
    password == User.hash_password(clear_password)
  end
  
  def self.hash_password clear_password
    Digest::SHA1.hexdigest(clear_password)
  end
  
  def admin?
    is_admin
  end
  
  def update_attributes params, id=0
    had_an_error = false
    unless params[:password] == params[:password_confirmation] then
      errors.add(:password, ': "Passwort" und "Passwort wiederholen" nicht identisch!')
      had_an_error = true
    else
      self.password = User.hash_password(params[:password]) unless params[:password] == ""
    end
    
    # User-Objekt mit dem angegebenen loginnamen aus der datenbank laden
    user_in_db = User.find_by_login(params[:login])
    # Wenn nil, ist alles gut, dann kann der Loginname angenommen werden
    if user_in_db then
      # Ansonsten prüfen, dass der bearbeitet User mit dem "neuen" Loginnamen identisch ist
      if user_in_db == User.find_by_id(id) then
        self.login = params[:login]
      else # beim bearbeiten oder erstellen wurde ein vorhandener loginname, eines anderen benutzers, gewählt
        errors.add(:login, ': "Loginname" bereits vergeben!')
        had_an_error = true
      end
    else
      self.login = params[:login]
    end
    
    if params[:email].include?("@") && params[:email].include?(".") && params[:email].size >= 7 then
      self.email = params[:email] if params[:email]
    else
      errors.add(:email, ': "Mailadresse" scheint nicht korrekt zu sein!')
      had_an_error = true
    end
    
    self.firstname = params[:firstname] if params[:firstname]
    self.lastname = params[:lastname] if params[:lastname]
    self.is_admin = params[:is_admin] if params[:is_admin]
    self.replace_uncomplete_x = params[:replace_uncomplete_x] if params[:replace_uncomplete_x]
    self.replace_complete_x = params[:replace_complete_x] if params[:replace_complete_x]
    self.filterrelation = params[:filterrelation] if params[:filterrelation]
    self.show_ser_col_complete = params[:show_ser_col_complete] if params[:show_ser_col_complete]
    self.show_ser_col_uncomplete = params[:show_ser_col_uncomplete] if params[:show_ser_col_uncomplete]
    self.show_ser_col_seasoncount = params[:show_ser_col_seasoncount] if params[:show_ser_col_seasoncount]
    self.show_ser_col_episodecount = params[:show_ser_col_episodecount] if params[:show_ser_col_episodecount]
    self.show_sea_col_owner = params[:show_sea_col_owner] if params[:show_sea_col_owner]
    self.show_sea_col_episodecount = params[:show_sea_col_episodecount] if params[:show_sea_col_episodecount]
    
    self.save unless had_an_error
    return !had_an_error
  end
end
