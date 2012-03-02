class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :validate_session
  
  before_filter :validate_session, :except => [:login]
  
  Time::DATE_FORMATS[:de] = "%d.%m.%y %H:%M"
  
  private
  
  def validate_session
    redirect_to :controller => "session", :action => "login", warning: "Nicht eingeloggt!" unless
      session[:s_id] && (Session.find(session[:s_id]).user.id == session[:user_id])
  end
end