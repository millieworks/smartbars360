require "minitest_helper"

describe "Customer Management Acceptance Test" do

  # Use cases
  #  - Admin creates new customer
  #  - Admin changes customer name
  #  - Admin deletes customer (see selenium tests)

  describe "without Javascript" do
    include TransactionalTestHelpers
    include AcceptanceTestHelpers

    before :each do
      Fabricate(:admin)
    end

    it "super admin creates a new customer" do
      sign_in_as_admin
      click_link "Customers"
      click_link "New customer"
      fill_in "Name", with: "Test Customer"
      click_button "Create"
      page.must_have_content "Test Customer"
    end

    it "super admin changes customer name" do
      Fabricate(:customer, name: "Original customer name")
      sign_in_as_admin
      click_link "Customers"
      click_link "Edit"
      fill_in "Name", with: "New customer name"
      click_button "Save"
      page.must_have_content "New customer name"
      page.wont_have_content "Original customer name"
    end
  end

  describe "with Selenium" do
    include SeleniumTestHelpers

    it "admin deletes a customer" do
      Fabricate(:admin)

      sign_in_as_admin
      click_link "Customers"
      page.must_have_content "No customers"
      Fabricate(:customer)

      visit current_path
      page.wont_have_content "No customers"
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      page.must_have_content "Customer was successfully deleted."
      page.must_have_content "No customers"
    end
  end
end