require 'test_helper'

class Admin::GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_group = admin_groups(:one)
  end

  test "should get index" do
    get admin_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_group_url
    assert_response :success
  end

  test "should create admin_group" do
    assert_difference('Admin::Group.count') do
      post admin_groups_url, params: { admin_group: { description: @admin_group.description, level: @admin_group.level, name: @admin_group.name } }
    end

    assert_redirected_to admin_group_url(Admin::Group.last)
  end

  test "should show admin_group" do
    get admin_group_url(@admin_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_group_url(@admin_group)
    assert_response :success
  end

  test "should update admin_group" do
    patch admin_group_url(@admin_group), params: { admin_group: { description: @admin_group.description, level: @admin_group.level, name: @admin_group.name } }
    assert_redirected_to admin_group_url(@admin_group)
  end

  test "should destroy admin_group" do
    assert_difference('Admin::Group.count', -1) do
      delete admin_group_url(@admin_group)
    end

    assert_redirected_to admin_groups_url
  end
end
