require 'test_helper'

class Admin::PermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_permission = admin_permissions(:one)
  end

  test "should get index" do
    get admin_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_permission_url
    assert_response :success
  end

  test "should create admin_permission" do
    assert_difference('Admin::Permission.count') do
      post admin_permissions_url, params: { admin_permission: { description: @admin_permission.description, name: @admin_permission.name, value: @admin_permission.value } }
    end

    assert_redirected_to admin_permission_url(Admin::Permission.last)
  end

  test "should show admin_permission" do
    get admin_permission_url(@admin_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_permission_url(@admin_permission)
    assert_response :success
  end

  test "should update admin_permission" do
    patch admin_permission_url(@admin_permission), params: { admin_permission: { description: @admin_permission.description, name: @admin_permission.name, value: @admin_permission.value } }
    assert_redirected_to admin_permission_url(@admin_permission)
  end

  test "should destroy admin_permission" do
    assert_difference('Admin::Permission.count', -1) do
      delete admin_permission_url(@admin_permission)
    end

    assert_redirected_to admin_permissions_url
  end
end
