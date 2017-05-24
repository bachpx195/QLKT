class AddPrePaymentToBills < ActiveRecord::Migration[5.0]
  def change
    add_column :bills, :pre_payment, :integer
  end
end
