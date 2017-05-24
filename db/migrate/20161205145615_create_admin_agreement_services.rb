class CreateAdminAgreementServices < ActiveRecord::Migration[5.0]
  def change
    create_table :agreement_services do |t|
      t.references :user, foreign_key: true
      t.references :agreement, foreign_key: true
      t.references :service, foreign_key: true
      t.integer :amount_perservice

      t.timestamps
    end
  end
end
