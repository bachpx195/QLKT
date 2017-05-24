json.extract! admin_bill_detail, :id, :user_id, :bill_id, :service_id, :amount, :unit_price, :total, :created_at, :updated_at
json.url admin_bill_detail_url(admin_bill_detail, format: :json)