require 'test_helper'

class Admin::GroupPermissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_group_permission = admin_group_permissions(:one)
  end

  test "should get index" do
    get admin_group_permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_group_permission_url
    assert_response :success
  end

  test "should create admin_group_permission" do
    assert_difference('Admin::GroupPermission.count') do
      post admin_group_permissions_url, params: { admin_group_permission: { function_id: @admin_group_permission.function_id, group_id: @admin_group_permission.group_id, permission_id: @admin_group_permission.permission_id } }
    end

    assert_redirected_to admin_group_permission_url(Admin::GroupPermission.last)
  end

  test "should show admin_group_permission" do
    get admin_group_permission_url(@admin_group_permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_group_permission_url(@admin_group_permission)
    assert_response :success
  end

  test "should update admin_group_permission" do
    patch admin_group_permission_url(@admin_group_permission), params: { admin_group_permission: { function_id: @admin_group_permission.function_id, group_id: @admin_group_permission.group_id, permission_id: @admin_group_permission.permission_id } }
    assert_redirected_to admin_group_permission_url(@admin_group_permission)
  end

  test "should destroy admin_group_permission" do
    assert_difference('Admin::GroupPermission.count', -1) do
      delete admin_group_permission_url(@admin_group_permission)
    end

    assert_redirected_to admin_group_permissions_url
  end
end
