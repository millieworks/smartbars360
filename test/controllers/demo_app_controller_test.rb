require "minitest_helper"

describe DemoAppController do
  before :each do
    @customer = Fabricate(:customer, name: "Demo Application")
  end

  it "must set an invalid api_key" do
    get :invalid_api_key
    assert_equal assigns(:api_key), "invalid"
  end

  it "must set a valid api_key on the home page" do
    get :index
    assert_equal assigns(:api_key), @customer.api_key
  end

  it "must set a valid api_key on the cookie policy page" do
    get :cookies
    assert_equal assigns(:api_key), @customer.api_key
  end
end