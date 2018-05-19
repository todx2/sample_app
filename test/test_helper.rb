

#may 16 2018
#require File.expand_path('../../config/environment', __FILE__)
#require 'rails/test_help'


ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  #ted boolean added..may 18 2018 
  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end


end
