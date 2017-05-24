require 'test_helper'

class Admin::ConfigCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_config_category = admin_config_categories(:one)
  end

  test "should get index" do
    get admin_config_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_config_category_url
    assert_response :success
  end

  test "should create admin_config_category" do
    assert_difference('Admin::ConfigCategory.count') do
      post admin_config_categories_url, params: { admin_config_category: { description: @admin_config_category.description, name: @admin_config_category.name, value: @admin_config_category.value } }
    end

    assert_redirected_to admin_config_category_url(Admin::ConfigCategory.last)
  end

  test "should show admin_config_category" do
    get admin_config_category_url(@admin_config_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_config_category_url(@admin_config_category)
    assert_response :success
  end

  test "should update admin_config_category" do
    patch admin_config_category_url(@admin_config_category), params: { admin_config_category: { description: @admin_config_category.description, name: @admin_config_category.name, value: @admin_config_category.value } }
    assert_redirected_to admin_config_category_url(@admin_config_category)
  end

  test "should destroy admin_config_category" do
    assert_difference('Admin::ConfigCategory.count', -1) do
      delete admin_config_category_url(@admin_config_category)
    end

    assert_redirected_to admin_config_categories_url
  end
end
