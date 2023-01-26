require "test_helper"

class FavolitesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favolites_create_url
    assert_response :success
  end

  test "should get new" do
    get favolites_new_url
    assert_response :success
  end

  test "should get destroy" do
    get favolites_destroy_url
    assert_response :success
  end
end
