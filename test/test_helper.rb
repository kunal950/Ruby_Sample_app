ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
include ApplicationHelper

module ActiveSupport
  class TestCase
    fixtures :all

    # Unit test version (Direct session manipulation)
    def is_logged_in?
      !session[:user_id].nil?
    end

    def log_in_as(user)
      session[:user_id] = user.id
    end
  end
end

class ActionDispatch::IntegrationTest
  # Integration version (Simulates a real form submission)
  def log_in_as(user, password: "password", remember_me: "1")
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end
