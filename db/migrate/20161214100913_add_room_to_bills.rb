class AddRoomToBills < ActiveRecord::Migration[5.0]
  def change
    add_reference :bills, :room, foreign_key: true
  end
end
