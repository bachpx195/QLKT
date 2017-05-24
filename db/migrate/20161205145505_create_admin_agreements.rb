class CreateAdminAgreements < ActiveRecord::Migration[5.0]
  def change
    create_table :agreements do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.references :renter, foreign_key: true
      t.string :code
      t.integer :duration
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :out_date
      t.integer :down_payment
      t.integer :pre_payment
      t.integer :billing_cycle
      t.integer :status

      t.timestamps
    end
  end
end
