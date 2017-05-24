require 'test_helper'

class Admin::RoomDevicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_room_device = admin_room_devices(:one)
  end

  test "should get index" do
    get admin_room_devices_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_room_device_url
    assert_response :success
  end

  test "should create admin_room_device" do
    assert_difference('Admin::RoomDevice.count') do
      post admin_room_devices_url, params: { admin_room_device: { amount: @admin_room_device.amount, description: @admin_room_device.description, name: @admin_room_device.name, room_id: @admin_room_device.room_id, status: @admin_room_device.status, user_id: @admin_room_device.user_id } }
    end

    assert_redirected_to admin_room_device_url(Admin::RoomDevice.last)
  end

  test "should show admin_room_device" do
    get admin_room_device_url(@admin_room_device)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_room_device_url(@admin_room_device)
    assert_response :success
  end

  test "should update admin_room_device" do
    patch admin_room_device_url(@admin_room_device), params: { admin_room_device: { amount: @admin_room_device.amount, description: @admin_room_device.description, name: @admin_room_device.name, room_id: @admin_room_device.room_id, status: @admin_room_device.status, user_id: @admin_room_device.user_id } }
    assert_redirected_to admin_room_device_url(@admin_room_device)
  end

  test "should destroy admin_room_device" do
    assert_difference('Admin::RoomDevice.count', -1) do
      delete admin_room_device_url(@admin_room_device)
    end

    assert_redirected_to admin_room_devices_url
  end
end
