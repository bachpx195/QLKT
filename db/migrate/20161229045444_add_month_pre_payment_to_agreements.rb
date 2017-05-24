class AddMonthPrePaymentToAgreements < ActiveRecord::Migration[5.0]
  def change
    add_column :agreements, :month_pre_payment, :integer
  end
end
