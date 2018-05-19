class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #def selam
  #  render html: "hello, world!"
  #end
    include SessionsHelper


end
