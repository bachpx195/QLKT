class CreateAdminBuildings < ActiveRecord::Migration[5.0]
  def change
    create_table :buildings do |t|
      t.references :user, foreign_key: true
      t.references :parent, index: true
      t.string :code
      t.string :name
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
