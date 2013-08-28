require "minitest_helper"

describe "Create Smartbar Acceptance Test" do
  include SeleniumTestHelpers

  before :each do
    @customer = Fabricate(:customer, name: "Demo Application")
    @user = Fabricate(:user, customer_id: @customer.id)
  end

  it "customer user creates a new cookie compliance smartbar to be prepended to the body tag of all site pages" do
    sign_in_as("customer.user@example.com", "123456")
    click_link "Smartbars"
    click_link "New smartbar"
    fill_in "Name", with: "Cookie compliance"
    fill_in "URL", with: "HOSTNAME*"
    fill_in "Callback URL", with: "HOSTNAME_CALLBACK_URL"
    click_button "Next"
    fill_in "HTML", with: '<div id="os360-close"></div>'
    choose "body"
    choose "by prepending"
    click_button "Next"
    fill_in "CSS", with: "#os360-close {\n\tcolor: red;\n}"
    click_button "Next"
    page.must_have_content "RULES"
    click_button "Finish"
    page.must_have_content 'Smartbar was successfully created.'
  end
end
