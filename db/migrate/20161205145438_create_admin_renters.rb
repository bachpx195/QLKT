class CreateAdminRenters < ActiveRecord::Migration[5.0]
  def change
    create_table :renters do |t|
      t.references :user, foreign_key: true
      t.string :code
      t.string :name
      t.datetime :birthday
      t.integer :sex
      t.string :identity_card
      t.string :issued_card
      t.string :phone
      t.string :email
      t.string :address
      t.integer :career
      t.string :university
      t.string :parent_name
      t.string :parent_phone
      t.string :hometown
      t.integer :temporary_registration
      t.integer :owner
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
