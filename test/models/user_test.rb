require "minitest_helper"

describe User do
  include TransactionalTestHelpers

  it "must create a new user with a generated password" do
    customer = Fabricate(:customer)
    Fabricate(:customer_user_role)
    user = User.new_with_generated_password({ email: "another@example.com", customer_id: customer.id })
    user.save
    user.password.wont_be_nil
    user.email.must_equal "another@example.com"
    user.role?(:customer_user).must_equal true
  end

  it "must create a new administrator with a generated password" do
    Fabricate(:admin_role)
    user = User.new_with_generated_password({ email: "another@example.com" })
    user.save
    user.password.wont_be_nil
    user.email.must_equal "another@example.com"
    user.admin?.must_equal true
  end

  it "must have an email" do
    user = Fabricate(:user)
    user.email = nil
    user.valid?.must_equal false
  end

  it "must delete of non-admin user" do
    admin = Fabricate(:admin)
    user = Fabricate(:user)

    User.count.must_equal 2
    user.destroy
    User.count.must_equal 1
  end

  it "must allow deletion of non-last admin user" do
    admin_role = Fabricate(:admin_role)
    admin = Fabricate(:admin, roles: [admin_role])
    another_admin = Fabricate(:admin, email: "another.admin@onserver360.se", roles: [admin_role])

    User.admins.count.must_equal 2
    admin.destroy
    User.admins.count.must_equal 1
  end

  it "must not delete the last admin user" do
    admin = Fabricate(:admin)
    User.admins.count.must_equal 1
    admin.destroy
    User.admins.count.must_equal 1
  end

  it "must generate a 6 character string password" do
    User.generated_password.must_match /[0-9A-Z]{6}/i
  end
end
