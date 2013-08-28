require 'spec_helper'

describe "visitor agrees to cookie policy" do
  it "tracks page impressions and user acceptance of cookies", js: true do
    host = "http://127.0.0.1:#{page.driver.rack_server.port}"
    customer = Fabricate(:demo_application)
    Fabricate(:cookie_compliance_smartbar, customer_id: customer.id, url: "#{host}/demo_app, #{host}/demo_app/cookies")

    expect(TrackedUser.count).to eq(0)
    expect(TrackedUrl.count).to eq(0)
    expect(TrackedUserAction.count).to eq(0)

    visit "/demo_app"
    expect(page).to have_selector("#os360-widget")
    expect(page).to have_content("Cookies on the Demo Site")
    sleep 1
    expect(TrackedUser.count).to eq(1)
    expect(TrackedUrl.count).to eq(1)
    expect(TrackedUserAction.count).to eq(0)

    click_link "Continue"
    expect(page).not_to have_selector("#os360-widget")
    sleep 1
    expect(TrackedUser.count).to eq(1)
    expect(TrackedUrl.count).to eq(1)
    expect(TrackedUserAction.count).to eq(1)

    visit "/demo_app/cookies"
    expect(page).not_to have_selector("#os360-widget")
    sleep 1
    expect(TrackedUser.count).to eq(1)
    expect(TrackedUrl.count).to eq(2)
    expect(TrackedUserAction.count).to eq(1)

    visit "/demo_app"
    expect(page).not_to have_selector("#os360-widget")
    sleep 1
    expect(TrackedUser.count).to eq(1)
    expect(TrackedUrl.count).to eq(3)
    expect(TrackedUserAction.count).to eq(1)
  end
end