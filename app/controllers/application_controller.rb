class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :validate_session, :gen_users_fullname_comma_list
  before_filter :set_current_user, :validate_session, :except => [:login, :password]
  
  Time::DATE_FORMATS[:de] = "%d.%m.%y %H:%M"
  
  private
  
  def set_current_user
    User.set_current User.find(session[:user_id]) if session[:user_id]
  end
  
  def validate_session
    unless session[:s_id] && (Session.find(session[:s_id]).user.id == session[:user_id]) then
      flash[:warning] = "Nicht eingeloggt!"
      redirect_to :controller => "session", :action => "login"
    end
  end
  
  def gen_users_fullname_comma_list users_list
    result = ""
    users_list.each do |user|
      result += user.fullname
      result += ", " unless user == users_list.last
    end
    return result
  end

end