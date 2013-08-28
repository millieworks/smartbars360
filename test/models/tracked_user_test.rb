require "minitest_helper"

describe TrackedUser do
  include TransactionalTestHelpers

  it "must have a customer_id" do
    user = Fabricate(:tracked_user)
    user.customer_id = nil
    user.valid?.must_equal false
  end

  it "must generate a public user id on create" do
    tracked_user = TrackedUser.create(customer_id: 1)
    tracked_user.public_user_id.wont_be_nil
  end
end
