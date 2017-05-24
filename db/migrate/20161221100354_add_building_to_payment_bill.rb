class AddBuildingToPaymentBill < ActiveRecord::Migration[5.0]
  def change
    add_reference :payment_bills, :building, foreign_key: true
  end
end
