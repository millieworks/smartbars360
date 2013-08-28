require "minitest_helper"

describe Customer do
  include TransactionalTestHelpers

  before :each do
    @customer = Fabricate.build(:customer)
  end

  it "must have a name" do
    @customer.name = nil
    @customer.valid?.must_equal false
  end

  it "must have unique api_key" do
    @customer.save
    @new_customer = Customer.new
    @new_customer.name = "New test customer"
    @new_customer.api_key = @customer.api_key
    @new_customer.valid?.must_equal false
  end

  it "must create an api_key on create" do
    customer = Customer.create(name: "Test customer")
    customer.api_key.wont_equal nil
  end
end
