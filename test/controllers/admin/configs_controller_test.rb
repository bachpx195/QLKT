require 'test_helper'

class Admin::ConfigsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_config = admin_configs(:one)
  end

  test "should get index" do
    get admin_configs_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_config_url
    assert_response :success
  end

  test "should create admin_config" do
    assert_difference('Admin::Config.count') do
      post admin_configs_url, params: { admin_config: { code: @admin_config.code, description: @admin_config.description, user_id: @admin_config.user_id, value: @admin_config.value } }
    end

    assert_redirected_to admin_config_url(Admin::Config.last)
  end

  test "should show admin_config" do
    get admin_config_url(@admin_config)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_config_url(@admin_config)
    assert_response :success
  end

  test "should update admin_config" do
    patch admin_config_url(@admin_config), params: { admin_config: { code: @admin_config.code, description: @admin_config.description, user_id: @admin_config.user_id, value: @admin_config.value } }
    assert_redirected_to admin_config_url(@admin_config)
  end

  test "should destroy admin_config" do
    assert_difference('Admin::Config.count', -1) do
      delete admin_config_url(@admin_config)
    end

    assert_redirected_to admin_configs_url
  end
end
