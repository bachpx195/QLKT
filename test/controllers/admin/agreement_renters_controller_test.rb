require 'test_helper'

class Admin::AgreementRentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_agreement_renter = admin_agreement_renters(:one)
  end

  test "should get index" do
    get admin_agreement_renters_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_agreement_renter_url
    assert_response :success
  end

  test "should create admin_agreement_renter" do
    assert_difference('Admin::AgreementRenter.count') do
      post admin_agreement_renters_url, params: { admin_agreement_renter: { agreement_id: @admin_agreement_renter.agreement_id, renter_id: @admin_agreement_renter.renter_id, user_id: @admin_agreement_renter.user_id } }
    end

    assert_redirected_to admin_agreement_renter_url(Admin::AgreementRenter.last)
  end

  test "should show admin_agreement_renter" do
    get admin_agreement_renter_url(@admin_agreement_renter)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_agreement_renter_url(@admin_agreement_renter)
    assert_response :success
  end

  test "should update admin_agreement_renter" do
    patch admin_agreement_renter_url(@admin_agreement_renter), params: { admin_agreement_renter: { agreement_id: @admin_agreement_renter.agreement_id, renter_id: @admin_agreement_renter.renter_id, user_id: @admin_agreement_renter.user_id } }
    assert_redirected_to admin_agreement_renter_url(@admin_agreement_renter)
  end

  test "should destroy admin_agreement_renter" do
    assert_difference('Admin::AgreementRenter.count', -1) do
      delete admin_agreement_renter_url(@admin_agreement_renter)
    end

    assert_redirected_to admin_agreement_renters_url
  end
end
