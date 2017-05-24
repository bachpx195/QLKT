module RenterAgreement
  private
  def create_renters_agreement(user, agreement, renter_ids)
    if renter_ids.any?
      Admin::AgreementRenter.where(user: user, agreement: agreement).destroy_all
      renter_ids.each do |renter_id|
        @admin_agreement_renter = Admin::AgreementRenter.new
        @admin_agreement_renter.user = user
        @admin_agreement_renter.renter_id = renter_id
        @admin_agreement_renter.agreement = agreement
        @admin_agreement_renter.save
      end
    end
  end
  def create_services_agreement(user, agreement, service_ids, amounts, statuses)
    if service_ids.any?
      Admin::AgreementService.where(user: user, agreement: agreement).destroy_all
      service_ids.each_with_index  do |service_id, index|
        admin_agreement_service = Admin::AgreementService.new
        admin_agreement_service.user = user
        admin_agreement_service.service_id = service_id
        admin_agreement_service.agreement = agreement
        admin_agreement_service.amount_perservice = amounts[service_id]
        admin_agreement_service.status = statuses[service_id]

        admin_agreement_service.save
      end
    end
  end
end