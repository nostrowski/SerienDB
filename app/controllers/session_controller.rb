class SessionController < ApplicationController
  def login
    unless params[:login] && params[:password] then
      render "login"
    else
      @user = User.find_by_login params[:login]
      if @user then
        if @user.password_valid?(params[:password]) then
          new_session = Session.create(:user_id => @user.id)
          session[:s_id] = new_session.id
          session[:user_id] = @user.id
          redirect_to :controller => "series", notice: "Login erfolgreich!"
        else
          redirect_to :controller => "session", :action => "login", warning: "Passwort nicht korrekt!"
        end
      else
        redirect_to :controller => "session", :action => "login", warning: "Login-Name nicht korrekt!"
      end
    end
  end

  def logout
    Session.find(session[:s_id]).destroy if session[:s_id]
    session[:s_id] = nil
    session[:user_id] = nil
    redirect_to :controller => "session", :action => "login", notice: "Logout erfolgreich!"
  end
end
