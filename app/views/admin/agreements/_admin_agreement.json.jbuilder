json.extract! admin_agreement, :id, :user_id, :room_id, :renter_id, :code, :duration, :start_date, :end_date, :out_date, :down_payment, :pre_payment, :billing_cycle, :status, :created_at, :updated_at
json.url admin_agreement_url(admin_agreement, format: :json)