class CreateAdminAgreementRenters < ActiveRecord::Migration[5.0]
  def change
    create_table :agreement_renters do |t|
      t.references :user, foreign_key: true
      t.references :agreement, foreign_key: true
      t.references :renter, foreign_key: true

      t.timestamps
    end
  end
end
