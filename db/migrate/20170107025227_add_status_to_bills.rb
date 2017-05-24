class AddStatusToBills < ActiveRecord::Migration[5.0]
  def change
    add_column :bills, :status, :integer
  end
end
