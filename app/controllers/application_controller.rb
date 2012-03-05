class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :validate_session
  before_filter :set_current_user, :validate_session, :except => [:login]
  
  Time::DATE_FORMATS[:de] = "%d.%m.%y %H:%M"
  
  private
  
  def set_current_user
    User.set_current User.find(session[:user_id])
  end
  
  def validate_session
    unless session[:s_id] && (Session.find(session[:s_id]).user.id == session[:user_id]) then
      flash[:warning] = "Nicht eingeloggt!"
      redirect_to :controller => "session", :action => "login"
    end
  end

end