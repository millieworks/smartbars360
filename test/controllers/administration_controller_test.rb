require "minitest_helper"

describe AdministrationController do
  before do
    @admin = Fabricate(:admin)
    sign_in @admin
  end

  it "should get index" do
    get :index
    assert_response :success
  end
end
