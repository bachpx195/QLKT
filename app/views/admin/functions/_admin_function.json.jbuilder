json.extract! admin_function, :id, :parent_id, :name, :controller, :description, :created_at, :updated_at
json.url admin_function_url(admin_function, format: :json)