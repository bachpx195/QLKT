class CreateAdminServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.references :user, foreign_key: true
      t.references :building, foreign_key: true
      t.string :name
      t.integer :unit
      t.integer :unit_price
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
