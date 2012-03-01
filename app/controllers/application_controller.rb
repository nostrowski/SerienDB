class ApplicationController < ActionController::Base
  protect_from_forgery
  
  Time::DATE_FORMATS[:de] = "%d.%m.%y %H:%M"
end
