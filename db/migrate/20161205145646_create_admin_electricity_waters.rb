class CreateAdminElectricityWaters < ActiveRecord::Migration[5.0]
  def change
    create_table :electricity_waters do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.integer :year
      t.integer :month
      t.integer :start_electricity
      t.integer :end_electricity
      t.integer :total_electricity
      t.integer :start_water
      t.integer :end_water
      t.integer :total_water

      t.timestamps
    end
  end
end
