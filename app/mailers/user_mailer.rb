class UserMailer < ActionMailer::Base
  default from: "info@nijos.de"

  def send_password(user, password)
    @user = user
    @password = password
    mail(:to => user.email, :subject => 'SerienDB-RAN - Passwort')
  end
  
  def send_password_activation(user)
    @user = user
    mail(:to => user.email, :subject => 'SerienDB-RAN - Passwort erneuern')
  end
end