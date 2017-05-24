class ChangeUnitTypeInPaymentBill < ActiveRecord::Migration[5.0]
  def change
    change_column :payment_bills, :unit, :string
  end
end
