require 'test_helper'

class Admin::BuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_building = admin_buildings(:one)
  end

  test "should get index" do
    get admin_buildings_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_building_url
    assert_response :success
  end

  test "should create admin_building" do
    assert_difference('Admin::Building.count') do
      post admin_buildings_url, params: { admin_building: { code: @admin_building.code, description: @admin_building.description, name: @admin_building.name, parent_id: @admin_building.parent_id, user_id: @admin_building.user_id } }
    end

    assert_redirected_to admin_building_url(Admin::Building.last)
  end

  test "should show admin_building" do
    get admin_building_url(@admin_building)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_building_url(@admin_building)
    assert_response :success
  end

  test "should update admin_building" do
    patch admin_building_url(@admin_building), params: { admin_building: { code: @admin_building.code, description: @admin_building.description, name: @admin_building.name, parent_id: @admin_building.parent_id, user_id: @admin_building.user_id } }
    assert_redirected_to admin_building_url(@admin_building)
  end

  test "should destroy admin_building" do
    assert_difference('Admin::Building.count', -1) do
      delete admin_building_url(@admin_building)
    end

    assert_redirected_to admin_buildings_url
  end
end
