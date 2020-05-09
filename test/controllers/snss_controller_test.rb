require 'test_helper'

class SnssControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get snss_index_url
    assert_response :success
  end

  test "should get show" do
    get snss_show_url
    assert_response :success
  end

  test "should get new" do
    get snss_new_url
    assert_response :success
  end

  test "should get create" do
    get snss_create_url
    assert_response :success
  end

  test "should get edit" do
    get snss_edit_url
    assert_response :success
  end

  test "should get update" do
    get snss_update_url
    assert_response :success
  end

end
