module SignInHelpers
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

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include SignInHelpers, type: :request
end