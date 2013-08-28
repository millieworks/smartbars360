require 'spec_helper'

describe "create smartbar" do
  before :each do
    @host = "http://127.0.0.1:#{page.driver.rack_server.port}"
    @customer = Fabricate(:customer, name: "Demo Application")
    @user = Fabricate(:user, customer: @customer)
    Fabricate(:inline_format_template)
    Fabricate(:cookie_compliance_content_template)
    Fabricate(:visits_rule_type, default_value: 1, name: "First visit")
  end

  it "user creates custom smartbar for first-time visitor", js: true do
    sign_in_as("customer.user@example.com", "123456")
    click_link "Smartbars"
    click_link "New smartbar"
    fill_in "Name", with: "Custom smartbar"
    fill_in "URL", with: "#{@host}/demo_app"
    fill_in "Callback URL", with: "#{@host}/callback"
    click_button "Next"

    # Skip templates
    expect(page).to have_content "Format"
    expect(page).to have_selector "select"
    click_button "Next"

    fill_in "HTML", with: '<a href="#" id="os360-close">Close</a>'
    choose "body"
    choose "by prepending"
    click_button "Next"
    fill_in "CSS", with: "#os360-close {\n\tcolor: red;\n}"
    click_button "Next"
    click_link "Add rule"
    select "First visit", from: "Rule type"
    sleep(2) # bug in webdriver?
    click_button "Finish"
    expect(page).to have_content 'Smartbar was successfully created.'

    # Verify smartbar appears
    visit "#{@host}/demo_app"
    expect(page).to have_selector "#os360-widget"
    click_link "Close"
    expect(page).to_not have_selector "#os360-widget"
  end

  it "user creates cookie compliance smartbar from template", js: true do
    sign_in_as("customer.user@example.com", "123456")
    click_link "Smartbars"
    click_link "New smartbar"
    fill_in "Name", with: "Cookie compliance"
    fill_in "URL", with: "#{@host}/demo_app*"
    fill_in "Callback URL", with: "#{@host}/callback"
    click_button "Next"
    select "Inline", from: 'Format'
    select "Cookie compliance", from: 'Content'
    click_button "Next"
    # Skip HTML
    click_button "Next"
    # Skip CSS
    click_button "Next"
    expect(page).to have_content "Add rule"
    click_button "Finish"
    expect(page).to have_content 'Smartbar was successfully created.'

    # Verify smartbar appears
    visit "#{@host}/demo_app"
    expect(page).to have_selector "#os360-widget"
    click_link "Continue"
    expect(page).to_not have_selector "#os360-widget"
  end
end