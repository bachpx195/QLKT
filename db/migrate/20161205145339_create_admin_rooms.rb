class CreateAdminRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.references :user, foreign_key: true
      t.references :building, foreign_key: true
      t.string :code
      t.string :name
      t.integer :room_type
      t.integer :amount
      t.integer :cost
      t.integer :status
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
