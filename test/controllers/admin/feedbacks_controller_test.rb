require 'test_helper'

class Admin::FeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_feedback = admin_feedbacks(:one)
  end

  test "should get index" do
    get admin_feedbacks_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_feedback_url
    assert_response :success
  end

  test "should create admin_feedback" do
    assert_difference('Admin::Feedback.count') do
      post admin_feedbacks_url, params: { admin_feedback: { description: @admin_feedback.description, user_id: @admin_feedback.user_id } }
    end

    assert_redirected_to admin_feedback_url(Admin::Feedback.last)
  end

  test "should show admin_feedback" do
    get admin_feedback_url(@admin_feedback)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_feedback_url(@admin_feedback)
    assert_response :success
  end

  test "should update admin_feedback" do
    patch admin_feedback_url(@admin_feedback), params: { admin_feedback: { description: @admin_feedback.description, user_id: @admin_feedback.user_id } }
    assert_redirected_to admin_feedback_url(@admin_feedback)
  end

  test "should destroy admin_feedback" do
    assert_difference('Admin::Feedback.count', -1) do
      delete admin_feedback_url(@admin_feedback)
    end

    assert_redirected_to admin_feedbacks_url
  end
end
