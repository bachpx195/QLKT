json.extract! admin_room_device, :id, :user_id, :room_id, :name, :amount, :status, :description, :created_at, :updated_at
json.url admin_room_device_url(admin_room_device, format: :json)