class CreateAdminBills < ActiveRecord::Migration[5.0]
  def change
    create_table :bills do |t|
      t.references :user, foreign_key: true
      t.references :agreement, foreign_key: true
      t.integer :year
      t.integer :month
      t.string :code
      t.datetime :bill_date
      t.integer :other_cost
      t.integer :debt_amount
      t.integer :total_amount
      t.integer :payment_amount
      t.integer :remain_amount
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
