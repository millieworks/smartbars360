require "minitest_helper"

describe CustomersController do
  before do
    @admin = Fabricate(:admin)
    sign_in @admin
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  it "must get new" do
    @customer = Customer.new
    get :new
    assert_response :success
  end

  it "must create customer" do
    assert_difference('Customer.count') do
      post :create, customer: { name: "Test customer" }
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  it "must not create an invalid customer" do
    post :create, customer: {}
    assert_template "new"
  end

  it "must show customer" do
    @customer = Fabricate(:customer)
    get :show, id: @customer.to_param
    assert_response :success
  end

  it "must get edit" do
    @customer = Fabricate(:customer)
    get :edit, id: @customer.to_param
    assert_response :success
  end

  it "must update customer" do
    @customer = Fabricate(:customer)
    put :update, id: @customer.to_param, customer: { name: "New test customer name" }
    assert_redirected_to customer_path(assigns(:customer))
  end

  it "must not update customer with invalid data" do
    @customer = Fabricate(:customer)
    put :update, id: @customer.to_param, customer: { name: nil }
    assert_template "edit"
  end

  it "must destroy customer" do
    @customer = Fabricate(:customer)
    assert_difference('Customer.count', -1) do
      delete :destroy, id: @customer.to_param
    end

    assert_redirected_to customers_path
  end

end
