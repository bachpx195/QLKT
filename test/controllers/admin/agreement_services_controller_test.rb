require 'test_helper'

class Admin::AgreementServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_agreement_service = admin_agreement_services(:one)
  end

  test "should get index" do
    get admin_agreement_services_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_agreement_service_url
    assert_response :success
  end

  test "should create admin_agreement_service" do
    assert_difference('Admin::AgreementService.count') do
      post admin_agreement_services_url, params: { admin_agreement_service: { agreement_id: @admin_agreement_service.agreement_id, amount_perservice: @admin_agreement_service.amount_perservice, service_id: @admin_agreement_service.service_id, user_id: @admin_agreement_service.user_id } }
    end

    assert_redirected_to admin_agreement_service_url(Admin::AgreementService.last)
  end

  test "should show admin_agreement_service" do
    get admin_agreement_service_url(@admin_agreement_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_agreement_service_url(@admin_agreement_service)
    assert_response :success
  end

  test "should update admin_agreement_service" do
    patch admin_agreement_service_url(@admin_agreement_service), params: { admin_agreement_service: { agreement_id: @admin_agreement_service.agreement_id, amount_perservice: @admin_agreement_service.amount_perservice, service_id: @admin_agreement_service.service_id, user_id: @admin_agreement_service.user_id } }
    assert_redirected_to admin_agreement_service_url(@admin_agreement_service)
  end

  test "should destroy admin_agreement_service" do
    assert_difference('Admin::AgreementService.count', -1) do
      delete admin_agreement_service_url(@admin_agreement_service)
    end

    assert_redirected_to admin_agreement_services_url
  end
end
