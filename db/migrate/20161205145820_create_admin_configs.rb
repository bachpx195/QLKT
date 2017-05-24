class CreateAdminConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :configs do |t|
      t.references :user, foreign_key: true
      t.string :code
      t.string :value
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
