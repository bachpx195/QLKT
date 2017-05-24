class CreateAdminPermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.integer :value
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
