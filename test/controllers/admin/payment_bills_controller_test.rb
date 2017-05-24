require 'test_helper'

class Admin::PaymentBillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_payment_bill = admin_payment_bills(:one)
  end

  test "should get index" do
    get admin_payment_bills_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_payment_bill_url
    assert_response :success
  end

  test "should create admin_payment_bill" do
    assert_difference('Admin::PaymentBill.count') do
      post admin_payment_bills_url, params: { admin_payment_bill: { amount: @admin_payment_bill.amount, code: @admin_payment_bill.code, description: @admin_payment_bill.description, name: @admin_payment_bill.name, payment: @admin_payment_bill.payment, payment_date: @admin_payment_bill.payment_date, type: @admin_payment_bill.type, unit: @admin_payment_bill.unit, unit_price: @admin_payment_bill.unit_price, user_id: @admin_payment_bill.user_id } }
    end

    assert_redirected_to admin_payment_bill_url(Admin::PaymentBill.last)
  end

  test "should show admin_payment_bill" do
    get admin_payment_bill_url(@admin_payment_bill)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_payment_bill_url(@admin_payment_bill)
    assert_response :success
  end

  test "should update admin_payment_bill" do
    patch admin_payment_bill_url(@admin_payment_bill), params: { admin_payment_bill: { amount: @admin_payment_bill.amount, code: @admin_payment_bill.code, description: @admin_payment_bill.description, name: @admin_payment_bill.name, payment: @admin_payment_bill.payment, payment_date: @admin_payment_bill.payment_date, type: @admin_payment_bill.type, unit: @admin_payment_bill.unit, unit_price: @admin_payment_bill.unit_price, user_id: @admin_payment_bill.user_id } }
    assert_redirected_to admin_payment_bill_url(@admin_payment_bill)
  end

  test "should destroy admin_payment_bill" do
    assert_difference('Admin::PaymentBill.count', -1) do
      delete admin_payment_bill_url(@admin_payment_bill)
    end

    assert_redirected_to admin_payment_bills_url
  end
end
