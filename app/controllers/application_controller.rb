class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :validate_session, :gen_users_fullname_comma_list
  before_filter :set_current_user, :validate_session, :except => [:login, :password]
  before_filter :valid_email, :except => [:login, :logout, :password]
  
  Time::DATE_FORMATS[:de] = "%d.%m.%y %H:%M"
  
  private
  
  def set_current_user
    User.set_current User.find(session[:user_id]) if session[:user_id]
  end
  
  def validate_session
    unless session[:s_id] && session_userid_correct? then
      flash[:alert] = t('alert.no_login')
      redirect_to :controller => "session", :action => "login"
    end
  end
  
  def session_userid_correct?
    db_session = Session.find_by_id(session[:s_id])
    if db_session then
      if db_session.user.id == session[:user_id] then
        return true
      else
        return false
      end
    else
      return false
    end
  end
  
  def valid_email
    unless User.current.email_valid? then
      flash[:alert] = t('alert.validate_email')
      redirect_to :controller => 'users', :action => 'edit' , :id => User.current.id
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