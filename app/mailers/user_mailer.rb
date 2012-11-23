class UserMailer < ActionMailer::Base
  default from: "info@nijos.de"

  def send_password(user, password)
    @user = user
    @password = password
    mail(:to => user.email, :subject => 'Neues Passwort fuer SerienDB-RAN')
  end
end