class CreateAdminGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :level
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
