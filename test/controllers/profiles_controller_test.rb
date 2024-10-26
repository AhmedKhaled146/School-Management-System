require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get api/v1/students" do
    get profiles_api/v1/students_url
    assert_response :success
  end

  test "should get show" do
    get profiles_show_url
    assert_response :success
  end

  test "should get update" do
    get profiles_update_url
    assert_response :success
  end
end
