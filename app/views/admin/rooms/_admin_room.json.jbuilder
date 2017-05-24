json.extract! admin_room, :id, :user_id, :building_id, :code, :name, :room_type, :amount, :cost, :status, :description, :created_at, :updated_at
json.url admin_room_url(admin_room, format: :json)