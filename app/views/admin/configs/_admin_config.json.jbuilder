json.extract! admin_config, :id, :user_id, :code, :value, :description, :created_at, :updated_at
json.url admin_config_url(admin_config, format: :json)