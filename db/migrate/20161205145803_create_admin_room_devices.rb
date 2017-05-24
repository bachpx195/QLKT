class CreateAdminRoomDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :room_devices do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.string :name
      t.integer :amount
      t.integer :status
      t.string :description, limit: 500

      t.timestamps
    end
  end
end
