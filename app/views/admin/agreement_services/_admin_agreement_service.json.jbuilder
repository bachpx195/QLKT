json.extract! admin_agreement_service, :id, :user_id, :agreement_id, :service, :amount_perservice, :created_at, :updated_at
json.url admin_agreement_service_url(admin_agreement_service, format: :json)