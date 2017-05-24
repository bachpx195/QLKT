require 'test_helper'

class Admin::BillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_bill = admin_bills(:one)
  end

  test "should get index" do
    get admin_bills_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_bill_url
    assert_response :success
  end

  test "should create admin_bill" do
    assert_difference('Admin::Bill.count') do
      post admin_bills_url, params: { admin_bill: { agreement_id: @admin_bill.agreement_id, bill_date: @admin_bill.bill_date, code: @admin_bill.code, debt_amount: @admin_bill.debt_amount, description: @admin_bill.description, month: @admin_bill.month, other_cost: @admin_bill.other_cost, payment_amount: @admin_bill.payment_amount, remain_amount: @admin_bill.remain_amount, total_amount: @admin_bill.total_amount, user_id: @admin_bill.user_id, year: @admin_bill.year } }
    end

    assert_redirected_to admin_bill_url(Admin::Bill.last)
  end

  test "should show admin_bill" do
    get admin_bill_url(@admin_bill)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_bill_url(@admin_bill)
    assert_response :success
  end

  test "should update admin_bill" do
    patch admin_bill_url(@admin_bill), params: { admin_bill: { agreement_id: @admin_bill.agreement_id, bill_date: @admin_bill.bill_date, code: @admin_bill.code, debt_amount: @admin_bill.debt_amount, description: @admin_bill.description, month: @admin_bill.month, other_cost: @admin_bill.other_cost, payment_amount: @admin_bill.payment_amount, remain_amount: @admin_bill.remain_amount, total_amount: @admin_bill.total_amount, user_id: @admin_bill.user_id, year: @admin_bill.year } }
    assert_redirected_to admin_bill_url(@admin_bill)
  end

  test "should destroy admin_bill" do
    assert_difference('Admin::Bill.count', -1) do
      delete admin_bill_url(@admin_bill)
    end

    assert_redirected_to admin_bills_url
  end
end
