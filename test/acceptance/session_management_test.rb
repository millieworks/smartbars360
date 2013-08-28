require "minitest_helper"

describe "Session Management Acceptance Test" do
  include TransactionalTestHelpers
  include AcceptanceTestHelpers

  # Use cases
  #  - Sign in and out DONE

  it "users can sign in and out" do
    Fabricate(:user)
    visit root_path
    page.must_have_content "You need to sign in before continuing."
    sign_in_as("customer.user@example.com", "123456")
    page.must_have_content "Signed in successfully"
    page.must_have_content "Sign out"
    click_link "Sign out"
    page.must_have_content "You need to sign in before continuing."
  end
end
