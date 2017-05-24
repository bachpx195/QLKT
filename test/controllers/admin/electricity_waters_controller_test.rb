require 'test_helper'

class Admin::ElectricityWatersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_electricity_water = admin_electricity_waters(:one)
  end

  test "should get index" do
    get admin_electricity_waters_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_electricity_water_url
    assert_response :success
  end

  test "should create admin_electricity_water" do
    assert_difference('Admin::ElectricityWater.count') do
      post admin_electricity_waters_url, params: { admin_electricity_water: { end_electricity: @admin_electricity_water.end_electricity, end_water: @admin_electricity_water.end_water, month: @admin_electricity_water.month, room_id: @admin_electricity_water.room_id, start_electricity: @admin_electricity_water.start_electricity, start_water: @admin_electricity_water.start_water, total_electricity: @admin_electricity_water.total_electricity, total_water: @admin_electricity_water.total_water, user_id: @admin_electricity_water.user_id, year: @admin_electricity_water.year } }
    end

    assert_redirected_to admin_electricity_water_url(Admin::ElectricityWater.last)
  end

  test "should show admin_electricity_water" do
    get admin_electricity_water_url(@admin_electricity_water)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_electricity_water_url(@admin_electricity_water)
    assert_response :success
  end

  test "should update admin_electricity_water" do
    patch admin_electricity_water_url(@admin_electricity_water), params: { admin_electricity_water: { end_electricity: @admin_electricity_water.end_electricity, end_water: @admin_electricity_water.end_water, month: @admin_electricity_water.month, room_id: @admin_electricity_water.room_id, start_electricity: @admin_electricity_water.start_electricity, start_water: @admin_electricity_water.start_water, total_electricity: @admin_electricity_water.total_electricity, total_water: @admin_electricity_water.total_water, user_id: @admin_electricity_water.user_id, year: @admin_electricity_water.year } }
    assert_redirected_to admin_electricity_water_url(@admin_electricity_water)
  end

  test "should destroy admin_electricity_water" do
    assert_difference('Admin::ElectricityWater.count', -1) do
      delete admin_electricity_water_url(@admin_electricity_water)
    end

    assert_redirected_to admin_electricity_waters_url
  end
end
