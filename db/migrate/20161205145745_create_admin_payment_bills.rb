class CreateAdminPaymentBills < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_bills do |t|
      t.references :user, foreign_key: true
      t.string :code
      t.string :name
      t.datetime :payment_date
      t.integer :payment_type
      t.integer :amount
      t.integer :unit
      t.integer :unit_price
      t.integer :payment
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
