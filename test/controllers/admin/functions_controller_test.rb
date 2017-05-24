require 'test_helper'

class Admin::FunctionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_function = admin_functions(:one)
  end

  test "should get index" do
    get admin_functions_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_function_url
    assert_response :success
  end

  test "should create admin_function" do
    assert_difference('Admin::Function.count') do
      post admin_functions_url, params: { admin_function: { controller: @admin_function.controller, description: @admin_function.description, name: @admin_function.name, parent_id: @admin_function.parent_id } }
    end

    assert_redirected_to admin_function_url(Admin::Function.last)
  end

  test "should show admin_function" do
    get admin_function_url(@admin_function)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_function_url(@admin_function)
    assert_response :success
  end

  test "should update admin_function" do
    patch admin_function_url(@admin_function), params: { admin_function: { controller: @admin_function.controller, description: @admin_function.description, name: @admin_function.name, parent_id: @admin_function.parent_id } }
    assert_redirected_to admin_function_url(@admin_function)
  end

  test "should destroy admin_function" do
    assert_difference('Admin::Function.count', -1) do
      delete admin_function_url(@admin_function)
    end

    assert_redirected_to admin_functions_url
  end
end
