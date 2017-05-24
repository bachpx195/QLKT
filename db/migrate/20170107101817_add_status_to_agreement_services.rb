class AddStatusToAgreementServices < ActiveRecord::Migration[5.0]
  def change
    add_column :agreement_services, :status, :integer
  end
end
