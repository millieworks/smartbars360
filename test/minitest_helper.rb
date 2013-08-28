if ENV["SIMPLECOV"]
  require 'simplecov'
  SimpleCov.start 'rails'
end


ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"
require 'database_cleaner'
#require "capybara/poltergeist"

module TransactionalTestHelpers
  def setup
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end

module AcceptanceTestHelpers
  def sign_in_as_admin
    sign_in_as("admin@onserver360.se", "123456")
  end

  def sign_in_as(email, password)
    visit new_user_session_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Sign in"
  end
end

module SeleniumTestHelpers
  include AcceptanceTestHelpers

  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    ::Capybara.current_driver = :selenium
  end

  def teardown
    DatabaseCleaner.clean
    ::Capybara.reset_sessions!
    ::Capybara.use_default_driver
  end
end


class MiniTest::Rails::ActiveSupport::TestCase
  self.use_transactional_fixtures = false
end

class MiniTest::Rails::ActionController::TestCase
  include Devise::TestHelpers
  include TransactionalTestHelpers
end