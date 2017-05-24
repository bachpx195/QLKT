json.extract! admin_group, :id, :name, :level, :description, :created_at, :updated_at
json.url admin_group_url(admin_group, format: :json)