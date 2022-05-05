require "test_helper"

class Public::RestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_rests_index_url
    assert_response :success
  end

  test "should get show" do
    get public_rests_show_url
    assert_response :success
  end

  test "should get new" do
    get public_rests_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_rests_edit_url
    assert_response :success
  end
end
