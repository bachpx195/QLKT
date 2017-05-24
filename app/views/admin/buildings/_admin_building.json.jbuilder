json.extract! admin_building, :id, :user_id, :parent_id, :code, :name, :description, :created_at, :updated_at
json.url admin_building_url(admin_building, format: :json)