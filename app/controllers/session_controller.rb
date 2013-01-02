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
          
          redirect_to Series, notice: t('notice.login')
        else
          flash[:alert] = t('alert.password_incorrect')
          redirect_to :action => 'login'
        end
      else
        flash[:alert] = t('alert.login_incorrect')
        redirect_to :action => 'login'
      end
    end
  end

  def logout
    Session.find(session[:s_id]).destroy if session[:s_id]
    session[:s_id] = nil
    session[:user_id] = nil
    User.set_current nil
    flash[:notice] = t('notice.logout')
    redirect_to :action => 'login'
  end
  
  def password
    unless params[:login] || params[:validation_code] then
      render 'password'
    else
      if params[:login] then
        user = User.find_by_login params[:login]
        if user then
          if user.email_valid? then
            user.validation_code = SecureRandom.hex(10)
            user.save
            UserMailer.send_password_activation(user).deliver
            flash[:notice] = t('notice.validation.link_send')
            redirect_to :action => 'login'
          else
            flash[:alert] = t('alert.validate_email_long')
            redirect_to :action => 'login'
          end
        else
          flash[:alert] = t('alert.login_incorrect')
          redirect_to :action => 'password'
        end
      else
        user = User.find_by_validation_code params[:validation_code]
        if user then
          user.validation_code = nil
          password = SecureRandom.hex(8)
          user.password = User.hash_password(password)
          user.save
          UserMailer.send_password(user, password).deliver
          flash[:notice] = t('notice.password_send')
          redirect_to :action => 'login'
        else
          flash[:alert] = t('alert.validation_incorrect')
          redirect_to :action => 'login'
        end
      end
    end
  end
  
  def changelog
    
  end
  
end
