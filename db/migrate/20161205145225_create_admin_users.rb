class CreateAdminUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :group, foreign_key: true
      t.string :password
      t.string :name
      t.integer :age
      t.integer :sex
      t.string :phone
      t.string :email
      t.string :address
      t.integer :actived
      t.string :aggrementno
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
