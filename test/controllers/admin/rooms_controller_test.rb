require 'test_helper'

class Admin::RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_room = admin_rooms(:one)
  end

  test "should get index" do
    get admin_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_room_url
    assert_response :success
  end

  test "should create admin_room" do
    assert_difference('Admin::Room.count') do
      post admin_rooms_url, params: { admin_room: { amount: @admin_room.amount, building_id: @admin_room.building_id, code: @admin_room.code, cost: @admin_room.cost, description: @admin_room.description, name: @admin_room.name, status: @admin_room.status, type: @admin_room.type, user_id: @admin_room.user_id } }
    end

    assert_redirected_to admin_room_url(Admin::Room.last)
  end

  test "should show admin_room" do
    get admin_room_url(@admin_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_room_url(@admin_room)
    assert_response :success
  end

  test "should update admin_room" do
    patch admin_room_url(@admin_room), params: { admin_room: { amount: @admin_room.amount, building_id: @admin_room.building_id, code: @admin_room.code, cost: @admin_room.cost, description: @admin_room.description, name: @admin_room.name, status: @admin_room.status, type: @admin_room.type, user_id: @admin_room.user_id } }
    assert_redirected_to admin_room_url(@admin_room)
  end

  test "should destroy admin_room" do
    assert_difference('Admin::Room.count', -1) do
      delete admin_room_url(@admin_room)
    end

    assert_redirected_to admin_rooms_url
  end
end
