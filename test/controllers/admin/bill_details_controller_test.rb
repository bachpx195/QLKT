require 'test_helper'

class Admin::BillDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_bill_detail = admin_bill_details(:one)
  end

  test "should get index" do
    get admin_bill_details_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_bill_detail_url
    assert_response :success
  end

  test "should create admin_bill_detail" do
    assert_difference('Admin::BillDetail.count') do
      post admin_bill_details_url, params: { admin_bill_detail: { amount: @admin_bill_detail.amount, bill_id: @admin_bill_detail.bill_id, service_id: @admin_bill_detail.service_id, total: @admin_bill_detail.total, unit_price: @admin_bill_detail.unit_price, user_id: @admin_bill_detail.user_id } }
    end

    assert_redirected_to admin_bill_detail_url(Admin::BillDetail.last)
  end

  test "should show admin_bill_detail" do
    get admin_bill_detail_url(@admin_bill_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_bill_detail_url(@admin_bill_detail)
    assert_response :success
  end

  test "should update admin_bill_detail" do
    patch admin_bill_detail_url(@admin_bill_detail), params: { admin_bill_detail: { amount: @admin_bill_detail.amount, bill_id: @admin_bill_detail.bill_id, service_id: @admin_bill_detail.service_id, total: @admin_bill_detail.total, unit_price: @admin_bill_detail.unit_price, user_id: @admin_bill_detail.user_id } }
    assert_redirected_to admin_bill_detail_url(@admin_bill_detail)
  end

  test "should destroy admin_bill_detail" do
    assert_difference('Admin::BillDetail.count', -1) do
      delete admin_bill_detail_url(@admin_bill_detail)
    end

    assert_redirected_to admin_bill_details_url
  end
end
