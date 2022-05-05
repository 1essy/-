require "test_helper"

class Admin::RestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_rests_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_rests_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_rests_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_rests_edit_url
    assert_response :success
  end
end
