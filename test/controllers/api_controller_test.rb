require "minitest_helper"

describe ApiController do
  before :each do
    @customer = Fabricate(:customer)
  end

  describe "bootstrap" do
    it "should get bootstrap for valid api_key" do
      get :bootstrap, format: :js, api_key: @customer.api_key
      assert_response :success
      assert_not_nil assigns(:api_key)
      assert_not_nil assigns(:host_with_scheme_and_port)
    end

    it "should create a javascript alert for an invalid api_key" do
      get :bootstrap, format: :js, api_key: "invalid_api_key"
      assert_response :success
      response.body.must_equal "alert('Invalid api_key');"
    end

    it "should raise Not Found for a missing api_key" do
      get :bootstrap, format: :js
      assert_response :success
      response.body.must_equal "alert('Invalid api_key');"
    end
  end

  describe "init" do
    it "should get for valid api_key and url" do
      get :init, format: :js, api_key: @customer.api_key, url: "http://www.example.com:8080/path?query=query"
      assert_response :success
      assert_not_nil assigns(:tracked_user)
      #assert_not_nil assigns(:api_key)
    end

    it "should raise Not Found valid for a missing url" do
      get :init, format: :js, api_key: @customer.api_key
      assert_response :not_found
    end

    it "should create a javascript alert for an invalid api_key" do
      get :init, format: :js, api_key: "invalid_api_key", url: "http://www.example.com:8080/path?query=query"
      assert_response :success
      response.body.must_equal "alert('Invalid api_key');"
    end

    it "should raise Not Found for a missing api_key" do
      get :bootstrap, format: :js, url: "http://www.example.com:8080/path?query=query"
      assert_response :success
      response.body.must_equal "alert('Invalid api_key');"
    end
  end

end
