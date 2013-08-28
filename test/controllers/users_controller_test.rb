require "minitest_helper"

describe UsersController do
  before do
    @admin = Fabricate(:admin)
    sign_in @admin
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  it "must get new" do
    @user = User.new
    get :new
    assert_response :success
  end

  it "must create user" do
    assert_difference('User.count') do
      post :create, user: { email: "another@example.com" }
    end

    assert_redirected_to users_path
  end

  it "must not create an invalid user" do
    post :create, user: {}
    assert_template "new"
  end

  it "must show user" do
    @user = Fabricate(:user)
    get :show, id: @user.to_param
    assert_response :success
  end

  it "must get edit" do
    @user = Fabricate(:user)
    get :edit, id: @user.to_param
    assert_response :success
  end

  it "must update user" do
    @user = Fabricate(:user)
    put :update, id: @user.to_param, user: { email: "another@example.com" }
    assert_redirected_to users_path
  end

  it "must not update user with invalid data" do
    @user = Fabricate(:user)
    put :update, id: @user.to_param, user: { email: nil }
    assert_template "edit"
  end

  it "must destroy user" do
    @user = Fabricate(:user)
    assert_difference('User.count', -1) do
      delete :destroy, id: @user.to_param
    end

    assert_redirected_to users_path
  end
end
