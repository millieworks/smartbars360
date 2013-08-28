require "minitest_helper"

describe "User Management Acceptance Test" do

  # Use cases
  #  - Admin creates a new customer user (password is generated) DONE
  #  - Admin creates a new admin (password is generated) DONE
  #  - Admin creates a new customer admin (password is generated) TBD
  #  - Admin changes a customer user's email address DONE
  #  - Admin makes existing customer user an admin DONE
  #  - Admin makes existing customer user a customer admin TBD
  #  - Admin deletes admin TBD
  #  - Admin deletes customer admin TBD
  #  - Admin deletes customer user (see selenium test) DONE

  #  - Customer admin creates a new customer user TBD
  #  - Customer admin creates a new customer admin TBD
  #  - Customer admin changes customer user's email TBD
  #  - Customer admin makes existing customer user a customer admin TBD
  #  - Customer admin deletes customer user TBD
  #  - Customer admin delete customer admin TBD

  #  - User changes own email address DONE
  #  - User has forgotten their password DONE
  #  - Enforce new user to change password if using generated TBD

  describe "without Javascript" do
    include TransactionalTestHelpers
    include AcceptanceTestHelpers

    before :each do
      Fabricate(:admin)
      @customer = Fabricate(:customer)
    end

    it "admin creates a new user" do
      Fabricate(:customer_user_role)
      sign_in_as_admin
      click_link "Users"
      click_link "New user"
      fill_in "Email", with: "another@example.com"
      select("Test customer", from: "Customer")
      click_button "Create"
      page.must_have_content "another@example.com"
      page.must_have_content "Test customer"

      mail = ActionMailer::Base.deliveries.last
      mail.to.must_equal ["another@example.com"]
      mail[:from].value.must_equal 'noreply@onserver360.se'
      mail.subject.must_equal "Welcome to ONSERVER360"
    end

    it "admin creates a new admin" do
      sign_in_as_admin
      click_link "Users"
      click_link "New user"
      fill_in "Email", with: "another.admin@onserver360.se"
      click_button "Create"
      page.must_have_content "another.admin@onserver360.se"

      mail = ActionMailer::Base.deliveries.last
      mail.to.must_equal ["another.admin@onserver360.se"]
      mail[:from].value.must_equal 'noreply@onserver360.se'
      mail.subject.must_equal "Welcome to ONSERVER360"
    end

    it "admin changes a user's email address" do
      user = Fabricate(:user, customer_id: @customer.id)
      sign_in_as_admin
      click_link "Users"
      find("a[href='/users/#{user.id}/edit']").click
      fill_in "Email", with: "different@example.com"
      click_button "Save"
      page.must_have_content "User was successfully updated."
      page.must_have_content "different@example.com"
      page.must_have_content "Test customer"
    end

    it "admin makes existing user an admin" do
      user = Fabricate(:user)
      sign_in_as_admin
      click_link "Users"
      find("a[href='/users/#{user.id}/edit']").click
      select("", from: "Customer")
      click_button "Save"
      page.must_have_content "User was successfully updated."
      # TODO verify actually an admin now
    end

    it "user changes their own email address" do
      user = Fabricate(:user, customer_id: @customer.id)
      sign_in_as "customer.user@example.com", "123456"
      click_link "Account"
      find("a[href='/users/#{user.id}/edit']").click
      fill_in "Email", with: "different@example.com"
      click_button "Save"
      page.must_have_content "User was successfully updated."
      page.must_have_content "different@example.com"
      page.must_have_content "Test customer"
    end

    it "user has forgotten their password" do
      user = Fabricate(:user)
      visit new_user_session_path
      click_link "Forgot your password?"
      fill_in "Email", with: "customer.user@example.com"
      click_button "Send reset instructions"

      mail = ActionMailer::Base.deliveries.last
      mail.to.must_equal ["customer.user@example.com"]
      mail[:from].value.must_equal 'noreply@onserver360.se'
      mail.subject.must_equal "Reset password instructions"
      matches = /reset_password_token=([^"]+)/.match(mail.body.encoded)

      visit edit_user_password_url(id: user.id, reset_password_token: matches[1])
      fill_in "Password", with: "111111"
      fill_in "Password confirmation", with: "111111"
      click_button "Change my password"
      page.must_have_content "Your password was changed successfully. You are now signed in."
    end
  end

  describe "with Selenium" do
    include SeleniumTestHelpers

    it "admin deletes a user" do
      Fabricate(:admin)

      sign_in_as_admin
      click_link "Users"
      page.must_have_selector "table tbody tr"
      page.wont_have_selector "table tbody tr + tr"
      Fabricate(:user)

      visit current_path
      page.must_have_selector "table tbody tr + tr"
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      page.must_have_content "User was successfully deleted."
      page.wont_have_selector "table tbody tr + tr"
    end
  end
end
