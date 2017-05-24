require 'test_helper'

class Admin::AgreementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_agreement = admin_agreements(:one)
  end

  test "should get index" do
    get admin_agreements_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_agreement_url
    assert_response :success
  end

  test "should create admin_agreement" do
    assert_difference('Admin::Agreement.count') do
      post admin_agreements_url, params: { admin_agreement: { billing_cycle: @admin_agreement.billing_cycle, code: @admin_agreement.code, down_payment: @admin_agreement.down_payment, duration: @admin_agreement.duration, end_date: @admin_agreement.end_date, out_date: @admin_agreement.out_date, pre_payment: @admin_agreement.pre_payment, renter_id: @admin_agreement.renter_id, room_id: @admin_agreement.room_id, start_date: @admin_agreement.start_date, status: @admin_agreement.status, user_id: @admin_agreement.user_id } }
    end

    assert_redirected_to admin_agreement_url(Admin::Agreement.last)
  end

  test "should show admin_agreement" do
    get admin_agreement_url(@admin_agreement)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_agreement_url(@admin_agreement)
    assert_response :success
  end

  test "should update admin_agreement" do
    patch admin_agreement_url(@admin_agreement), params: { admin_agreement: { billing_cycle: @admin_agreement.billing_cycle, code: @admin_agreement.code, down_payment: @admin_agreement.down_payment, duration: @admin_agreement.duration, end_date: @admin_agreement.end_date, out_date: @admin_agreement.out_date, pre_payment: @admin_agreement.pre_payment, renter_id: @admin_agreement.renter_id, room_id: @admin_agreement.room_id, start_date: @admin_agreement.start_date, status: @admin_agreement.status, user_id: @admin_agreement.user_id } }
    assert_redirected_to admin_agreement_url(@admin_agreement)
  end

  test "should destroy admin_agreement" do
    assert_difference('Admin::Agreement.count', -1) do
      delete admin_agreement_url(@admin_agreement)
    end

    assert_redirected_to admin_agreements_url
  end
end
