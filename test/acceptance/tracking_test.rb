require "minitest_helper"

describe "Tracking Acceptance Test" do
  include SeleniumTestHelpers

  # Use cases
  #  - Track a single user multiple times (page impressions)

  it "must track a user multiple times (page impressions)" do
    Fabricate(:customer, name: "Demo Application")
    TrackedUser.count.must_equal 0
    TrackedUrl.count.must_equal 0

    visit "/demo_app"
    sleep 1 # give code time to make insert into database
    TrackedUser.count.must_equal 1
    TrackedUser.first.page_impressions.must_equal 1
    TrackedUrl.count.must_equal 1

    visit "/demo_app"
    sleep 1 # give code time to make insert into database
    TrackedUser.count.must_equal 1
    TrackedUser.first.page_impressions.must_equal 2
    TrackedUrl.count.must_equal 2

    visit "/demo_app/cookies"
    sleep 1 # give code time to make insert into database
    TrackedUser.count.must_equal 1
    TrackedUser.first.page_impressions.must_equal 3
    TrackedUrl.count.must_equal 3
  end
end
