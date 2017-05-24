require 'test_helper'

class Admin::RentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_renter = admin_renters(:one)
  end

  test "should get index" do
    get admin_renters_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_renter_url
    assert_response :success
  end

  test "should create admin_renter" do
    assert_difference('Admin::Renter.count') do
      post admin_renters_url, params: { admin_renter: { address: @admin_renter.address, birthday: @admin_renter.birthday, career: @admin_renter.career, code: @admin_renter.code, description: @admin_renter.description, email: @admin_renter.email, hometown: @admin_renter.hometown, identity_card: @admin_renter.identity_card, issued_card: @admin_renter.issued_card, name: @admin_renter.name, owner: @admin_renter.owner, parent_name: @admin_renter.parent_name, parent_phone: @admin_renter.parent_phone, phone: @admin_renter.phone, sex: @admin_renter.sex, temporary_registration: @admin_renter.temporary_registration, university: @admin_renter.university, user_id: @admin_renter.user_id } }
    end

    assert_redirected_to admin_renter_url(Admin::Renter.last)
  end

  test "should show admin_renter" do
    get admin_renter_url(@admin_renter)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_renter_url(@admin_renter)
    assert_response :success
  end

  test "should update admin_renter" do
    patch admin_renter_url(@admin_renter), params: { admin_renter: { address: @admin_renter.address, birthday: @admin_renter.birthday, career: @admin_renter.career, code: @admin_renter.code, description: @admin_renter.description, email: @admin_renter.email, hometown: @admin_renter.hometown, identity_card: @admin_renter.identity_card, issued_card: @admin_renter.issued_card, name: @admin_renter.name, owner: @admin_renter.owner, parent_name: @admin_renter.parent_name, parent_phone: @admin_renter.parent_phone, phone: @admin_renter.phone, sex: @admin_renter.sex, temporary_registration: @admin_renter.temporary_registration, university: @admin_renter.university, user_id: @admin_renter.user_id } }
    assert_redirected_to admin_renter_url(@admin_renter)
  end

  test "should destroy admin_renter" do
    assert_difference('Admin::Renter.count', -1) do
      delete admin_renter_url(@admin_renter)
    end

    assert_redirected_to admin_renters_url
  end
end
