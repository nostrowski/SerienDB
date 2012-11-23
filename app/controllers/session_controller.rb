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
          Session.drop_old
          
          redirect_to Series, notice: "Login erfolgreich!"
        else
          flash[:alert] = "Passwort nicht korrekt!"
          redirect_to :action => 'login'
        end
      else
        flash[:alert] = "Login-Name nicht korrekt!"
        redirect_to :action => 'login'
      end
    end
  end

  def logout
    Session.find(session[:s_id]).destroy if session[:s_id]
    session[:s_id] = nil
    session[:user_id] = nil
    User.set_current nil
    flash[:notice] = "Logout erfolgreich!"
    redirect_to :action => 'login'
  end
  
  def password
    unless params[:login] && params[:email] then
      render 'password'
    else
      user = User.find_by_login params[:login]
      if user then
        if user.email == params[:email] then
          password = SecureRandom.hex(8)
          user.password = User.hash_password(password)
          user.save
          UserMailer.send_password(user, password).deliver
          flash[:notice] = "Neues Passwort wurde versandt!"
          redirect_to :action => 'login'
        else
          flash[:alert] = "Angegebene und hinterlegte Email-Adresse sind nicht identisch!"
          redirect_to :action => 'password'
        end
      else
        flash[:alert] = "Login-Name nicht korrekt!"
        redirect_to :action => 'password'
      end
    end
  end
  
end
