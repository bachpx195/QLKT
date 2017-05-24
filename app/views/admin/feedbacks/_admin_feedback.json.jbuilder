json.extract! admin_feedback, :id, :user_id, :description, :created_at, :updated_at
json.url admin_feedback_url(admin_feedback, format: :json)