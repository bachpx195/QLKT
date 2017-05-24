class CreateAdminFunctions < ActiveRecord::Migration[5.0]
  def change
    create_table :functions do |t|
      t.references :parent, index: true
      t.string :name
      t.string :controller
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
