class Admin::AgreementService < ApplicationRecord
  belongs_to :user
  belongs_to :agreement
  belongs_to :service

  def self.search_by_service(services)
      where(:service_id => services.map(&:id))
  end
end
